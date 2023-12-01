import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/screens/membership/utils_paginated_member_list.dart';
import 'package:poimen/services/cloudinary_service.dart';
import 'package:poimen/state/enums.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/alert_box.dart';
import 'package:poimen/widgets/avatar_with_initials.dart';
import 'package:poimen/widgets/no_data.dart';
import 'package:provider/provider.dart';
import 'package:infinite_scroll/infinite_scroll.dart';

class ChurchMembershipList extends StatelessWidget {
  const ChurchMembershipList({Key? key, required this.church, this.fetchMore}) : super(key: key);

  final ChurchWithPaginatedMemberQueries church;
  final FetchMore? fetchMore;

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    const headerStyle = TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold);
    double accordionHeight = MediaQuery.of(context).size.width > 500 ? 600.0 : 340.0;

    int totalCount = church.sheepCount + church.goatCount + church.deerCount;

    return ListView(
      children: [
        const Padding(padding: EdgeInsets.all(10)),
        Center(child: Text('Total Members: $totalCount')),
        Accordion(
          maxOpenSections: 1,
          scaleWhenAnimating: true,
          openAndCloseAnimation: true,
          paddingListHorizontal: 0,
          headerPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
          headerBackgroundColor: isDarkMode ? const Color(0xFF181818) : PoimenTheme.brand,
          headerBackgroundColorOpened: isDarkMode ? const Color(0xFF1A1A1A) : null,
          contentBackgroundColor:
              isDarkMode ? PoimenTheme.darkCardColor : PoimenTheme.lightCardColor,
          headerBorderRadius: 0,
          contentHorizontalPadding: 5,
          contentBorderWidth: 1,
          contentBorderColor: isDarkMode ? PoimenTheme.darkCardColor : PoimenTheme.lightCardColor,
          sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
          sectionClosingHapticFeedback: SectionHapticFeedback.light,
          children: [
            AccordionSection(
              isOpen: true,
              contentBorderRadius: 0,
              leftIcon: const Icon(FontAwesomeIcons.faceSmile, color: Colors.lightGreenAccent),
              header: Text('Sheep: ${church.sheepCount}', style: headerStyle),
              content: SizedBox(
                  height: accordionHeight,
                  child: MemberListQuery(query: church.sheepQuery, category: MemberCategory.Sheep)),
            ),
            AccordionSection(
              leftIcon: const Icon(FontAwesomeIcons.faceMeh, color: Colors.yellowAccent),
              contentBorderRadius: 0,
              header: Text('Goats: ${church.goatCount}', style: headerStyle),
              content: SizedBox(
                  height: accordionHeight,
                  child: MemberListQuery(query: church.goatQuery, category: MemberCategory.Goat)),
            ),
            AccordionSection(
              leftIcon: const Icon(FontAwesomeIcons.faceFrown, color: Colors.redAccent),
              contentBorderRadius: 0,
              header: Text('Deer: ${church.deerCount}', style: headerStyle),
              content: SizedBox(
                  height: accordionHeight,
                  child: MemberListQuery(query: church.deerQuery, category: MemberCategory.Deer)),
            ),
          ],
        ),
      ],
    );
  }
}

Column memberListTile(BuildContext context, MemberForList member) {
  CloudinaryImage picture = CloudinaryImage(url: member.pictureUrl, size: ImageSize.normal);
  var memberState = context.watch<SharedState>();

  return Column(
    children: [
      ListTile(
        onTap: () {
          memberState.member = member;
          memberState.memberId = member.id;
          Navigator.pushNamed(context, '/member-details');
        },
        title: Text('${member.firstName} ${member.lastName}'),
        subtitle: Text(member.typename),
        leading: Hero(
          tag: 'member-${member.id}',
          child: AvatarWithInitials(foregroundImage: picture.image, member: member),
        ),
      ),
      const Divider(thickness: 1)
    ],
  );
}

class MemberListQuery extends StatelessWidget {
  const MemberListQuery({
    Key? key,
    required this.query,
    required this.category,
  }) : super(key: key);

  final dynamic query;
  final MemberCategory category;

  @override
  Widget build(BuildContext context) {
    var churchState = context.watch<SharedState>();
    ChurchString churchString = ChurchString(churchState.church.typename.toLowerCase());

    const pageSize = 7;

    return Query(
        options: QueryOptions(
          document: query,
          variables: {'id': churchState.church.id, 'first': pageSize, 'after': 0},
        ),
        builder: (result, {fetchMore, refetch}) {
          if (result.hasException) {
            return Text(getGQLException(result.exception));
          }

          if ((result.data == null)) {
            return const Center(child: SizedBox(child: CircularProgressIndicator()));
          }

          final church =
              ChurchForPaginatedMemberList.fromJson(result.data?[churchString.pluralLowerCase][0]);

          PaginatedMemberList? members;

          if (category == MemberCategory.Sheep) {
            members = church.sheepPaginated;
          }
          if (category == MemberCategory.Goat) {
            members = church.goatsPaginated;
          }
          if (category == MemberCategory.Deer) {
            members = church.deerPaginated;
          }

          return MemberInfiniteScrollList(
            fetchMore: fetchMore!,
            position: members?.position ?? 0,
            category: category,
            children: noDataChecker(
              members?.edges.map((edge) {
                    return memberListTile(context, edge.node);
                  }).toList() ??
                  [],
            ),
          );
        });
  }
}

class MemberInfiniteScrollList extends StatefulWidget {
  const MemberInfiniteScrollList(
      {Key? key,
      required this.fetchMore,
      required this.children,
      required this.position,
      required this.category})
      : super(key: key);

  final FetchMore fetchMore;
  final MemberCategory category;
  final List<Widget> children;
  final int position;

  @override
  State<MemberInfiniteScrollList> createState() => _MemberInfiniteScrollListState();
}

class _MemberInfiniteScrollListState extends State<MemberInfiniteScrollList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var churchState = context.watch<SharedState>();
    ChurchString churchString = ChurchString(churchState.church.typename.toLowerCase());
    String churchLevel = churchString.pluralLowerCase;
    bool everyThingLoaded = widget.children.length < widget.position;

    return InfiniteScrollList(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      onLoadingStart: (page) async {
        FetchMoreOptions opts = FetchMoreOptions(
          variables: {'first': 7, 'after': widget.position},
          updateQuery: ((previousResultData, fetchMoreResultData) {
            final church =
                ChurchForPaginatedMemberList.fromJson(fetchMoreResultData?[churchLevel][0]);
            final previousChurchData =
                ChurchForPaginatedMemberList.fromJson(previousResultData?[churchLevel][0]);

            bool? done;
            if (widget.category == MemberCategory.Sheep) {
              done = (previousChurchData.sheepPaginated!.position >=
                  previousChurchData.sheepPaginated!.totalCount);
              final List<dynamic> sheep = [
                ...previousResultData?[churchLevel][0]['sheepPaginated']?['edges'] ?? [],
                ...fetchMoreResultData?[churchLevel][0]['sheepPaginated']?['edges'] ?? []
              ];
              fetchMoreResultData?[churchLevel][0]['sheepPaginated']?['edges'] = sheep;

              done = (church.sheepPaginated!.position >= church.sheepPaginated!.totalCount);
            }

            if (widget.category == MemberCategory.Goat) {
              done = (previousChurchData.goatsPaginated!.position >=
                  previousChurchData.goatsPaginated!.totalCount);
              final List<dynamic> goats = [
                ...previousResultData?[churchLevel][0]['goatsPaginated']?['edges'] ?? [],
                ...fetchMoreResultData?[churchLevel][0]['goatsPaginated']?['edges'] ?? []
              ];

              fetchMoreResultData?[churchLevel][0]['goatsPaginated']?['edges'] = goats;

              done = (church.goatsPaginated!.position >= church.goatsPaginated!.totalCount);
            }

            if (widget.category == MemberCategory.Deer) {
              done = (previousChurchData.deerPaginated!.position >=
                  previousChurchData.deerPaginated!.totalCount);
              final List<dynamic> deer = [
                ...previousResultData?[churchLevel][0]['deerPaginated']?['edges'] ?? [],
                ...fetchMoreResultData?[churchLevel][0]['deerPaginated']?['edges'] ?? []
              ];

              fetchMoreResultData?[churchLevel][0]['deerPaginated']?['edges'] = deer;
              done = (church.deerPaginated!.position >= church.deerPaginated!.totalCount);
            }

            if (done == true) {
              setState(() {
                everyThingLoaded = true;
              });
            }

            return fetchMoreResultData;
          }),
        );

        await widget.fetchMore(opts);
      },
      everythingLoaded: everyThingLoaded,
      children: widget.children,
    );
  }
}
