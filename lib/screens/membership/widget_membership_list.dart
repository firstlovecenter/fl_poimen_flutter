import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/screens/membership/widget_infinite_scroll.dart';
import 'package:poimen/services/cloudinary_service.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/avatar_with_initials.dart';
import 'package:poimen/widgets/no_data.dart';
import 'package:provider/provider.dart';

class ChurchMembershipList extends StatelessWidget {
  const ChurchMembershipList({
    Key? key,
    required this.church,
  }) : super(key: key);

  final ChurchForMemberList church;

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    const headerStyle = TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold);

    const double accordionHeight = 340;
    int memberCount = church.sheepPaginated.totalCount +
        church.goatsPaginated.totalCount +
        church.deerPaginated.totalCount;

    return Column(
      children: [
        const Padding(padding: EdgeInsets.all(10)),
        Text('Total Members: $memberCount'),
        const MemberListView(),
        Accordion(
          maxOpenSections: 1,
          scaleWhenAnimating: true,
          openAndCloseAnimation: true,
          paddingListHorizontal: 0,
          headerPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
          headerBackgroundColor: isDarkMode ? const Color(0xFF181818) : null,
          headerBackgroundColorOpened: isDarkMode ? const Color(0xFF1A1A1A) : null,
          contentBackgroundColor:
              isDarkMode ? PoimenTheme.darkCardColor : PoimenTheme.lightCardColor,
          headerBorderRadius: 0,
          contentHorizontalPadding: 5,
          contentBorderWidth: 1,
          sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
          sectionClosingHapticFeedback: SectionHapticFeedback.light,
          children: [
            AccordionSection(
              isOpen: true,
              contentBorderRadius: 0,
              leftIcon: const Icon(FontAwesomeIcons.faceSmile, color: Colors.lightGreenAccent),
              header: Text('Sheep: ${church.sheepPaginated.totalCount}', style: headerStyle),
              content: SizedBox(
                height: accordionHeight,
                child: ListView(
                  children: noDataChecker(
                    church.sheepPaginated.edges.map((edge) {
                      return memberListTile(context, edge.node);
                    }).toList(),
                  ),
                ),
              ),
            ),
            AccordionSection(
              leftIcon: const Icon(FontAwesomeIcons.faceMeh, color: Colors.yellowAccent),
              contentBorderRadius: 0,
              header: Text('Goats: ${church.goatsPaginated.totalCount}', style: headerStyle),
              content: SizedBox(
                height: accordionHeight,
                child: ListView(
                  children: noDataChecker(church.goatsPaginated.edges.map((edge) {
                    return memberListTile(context, edge.node);
                  }).toList()),
                ),
              ),
            ),
            AccordionSection(
              leftIcon: const Icon(FontAwesomeIcons.faceFrown, color: Colors.redAccent),
              contentBorderRadius: 0,
              header: Text('Deer: ${church.deerPaginated.totalCount}', style: headerStyle),
              content: SizedBox(
                height: accordionHeight,
                child: ListView(
                  children: noDataChecker(church.deerPaginated.edges.map((edge) {
                    return memberListTile(context, edge.node);
                  }).toList()),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

Column memberListTile(BuildContext context, MemberForList member) {
  CloudinaryImage picture = CloudinaryImage(url: member.pictureUrl, size: ImageSize.normal);
  var memberState = Provider.of<SharedState>(context);

  return Column(
    children: [
      ListTile(
        onTap: () {
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
