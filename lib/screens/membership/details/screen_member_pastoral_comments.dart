import 'package:flutter/material.dart';
import 'package:poimen/helpers/menus.dart';
import 'package:poimen/screens/membership/details/gql_member_details.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/services/cloudinary_service.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/avatar_with_initials.dart';
import 'package:poimen/services/gql_query_container.dart';
import 'package:poimen/widgets/bottom_nav_bar.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class MemberPastoralCommentsScreen extends StatelessWidget {
  const MemberPastoralCommentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<SharedState>(context);

    return GQLQueryContainer(
      query: getMemberPastoralComments,
      variables: {'id': state.memberId},
      defaultPageTitle: 'Member Pastoral Comments',
      bottomNavBar: const BottomNavBar(menu: getAttendanceMenus, index: 4),
      bodyFunction: (data, [fetchMore]) {
        final member = MemberWithComments.fromJson(data?['members'][0]);
        final picture = CloudinaryImage(url: member.pictureUrl, size: ImageSize.lg);

        const headerStyle = TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w500,
        );

        var returnValues = GQLQueryContainerReturnValue(
          pageTitle: const PageTitle(pageTitle: 'Member PastoralComments'),
          body: ListView(
            padding: const EdgeInsets.all(8.0),
            children: [
              const Padding(padding: EdgeInsets.all(8.0)),
              Center(
                child: Hero(
                  tag: 'member-${member.id}',
                  child: AvatarWithInitials(
                    foregroundImage: picture.image,
                    member: member,
                    radius: 80,
                  ),
                ),
              ),
              Chip(
                label: Text(member.status ?? 'No Status',
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                backgroundColor: member.status == 'Sheep'
                    ? PoimenTheme.good
                    : member.status == 'Goat'
                        ? PoimenTheme.warning
                        : member.status == 'Deer'
                            ? PoimenTheme.darkBrand
                            : PoimenTheme.bad,
              ),
              Center(
                  child: Text(
                '${member.firstName} ${member.lastName}',
                style: headerStyle,
              )),
              const Padding(padding: EdgeInsets.all(8.0)),
              Center(
                child: Text(
                  'Pastoral Comments',
                  style: PoimenTheme.heading2,
                ),
              ),
              const Padding(padding: EdgeInsets.all(8.0)),
              member.pastoralComments == null || member.pastoralComments!.isEmpty
                  ? Container()
                  : Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                        child: Column(
                          children: [
                            const Padding(padding: EdgeInsets.all(8.0)),
                            Column(
                              children: [
                                ...member.pastoralComments!.map((comment) {
                                  return Column(
                                    children: [
                                      if (member.pastoralComments!.indexOf(comment) != 0)
                                        const Divider(),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          comment.comment,
                                          style: const TextStyle(color: PoimenTheme.whatsappColor),
                                          overflow: TextOverflow.clip,
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  '${comment.author.firstName} ${comment.author.lastName}, ',
                                                ),
                                                Text(comment.activity),
                                              ],
                                            ),
                                            Text(
                                              timeago.format(comment.timestamp),
                                              style: const TextStyle(
                                                color: PoimenTheme.textSecondary,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                }).toList()
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        );

        return returnValues;
      },
    );
  }
}
