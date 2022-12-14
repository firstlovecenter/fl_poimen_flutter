import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:poimen/helpers/menus.dart';
import 'package:poimen/screens/membership/details/gql_member_details.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/services/cloudinary_service.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/avatar_with_initials.dart';
import 'package:poimen/services/gql_query_container.dart';
import 'package:poimen/widgets/bottom_nav_bar.dart';
import 'package:poimen/widgets/color_block_tile.dart';
import 'package:poimen/widgets/icon_contact.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class MemberDetailsScreen extends StatelessWidget {
  const MemberDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<SharedState>(context);

    return GQLQueryContainer(
      query: getMemberDetails,
      variables: {'id': state.memberId},
      defaultPageTitle: 'Member Details',
      bottomNavBar: const BottomNavBar(menu: getAttendanceMenus, index: 4),
      bodyFunction: (data, [fetchMore]) {
        final member = Member.fromJson(data?['members'][0]);
        final picture = CloudinaryImage(url: member.pictureUrl, size: ImageSize.lg);

        const headerStyle = TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w500,
        );

        var returnValues = GQLQueryContainerReturnValue(
          pageTitle: const PageTitle(pageTitle: 'Member Details'),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...member.lastSixServices.map((present) {
                    if (present) {
                      return Row(
                        children: const [
                          Padding(padding: EdgeInsets.all(4.0)),
                          CircleAvatar(
                            backgroundColor: Colors.green,
                            radius: 15,
                            child: Icon(
                              FontAwesomeIcons.check,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      );
                    }
                    return Row(
                      children: const [
                        Padding(padding: EdgeInsets.all(4.0)),
                        CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: 15,
                          child: Icon(
                            FontAwesomeIcons.xmark,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              ),
              const Padding(padding: EdgeInsets.all(8.0)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: ColorBlockTile(
                  leadingColor: PoimenTheme.darkBrand,
                  icon: FontAwesomeIcons.circleUp,
                  color: PoimenTheme.brand,
                  title: 'Membership Upgrades',
                  to: '/membership-upgrades',
                ),
              ),
              const Padding(padding: EdgeInsets.all(8.0)),
              BioDetailsCard(title: 'Sex', detail: member.gender.gender.name),
              BioDetailsCard(title: 'Date of Birth', detail: member.dob.humanReadable),
              BioDetailsCard(
                  title: 'Phone Number',
                  detail: '+${member.phoneNumber}',
                  phoneNumber: member.phoneNumber),
              BioDetailsCard(
                  title: 'Whatsapp Number',
                  detail: '+${member.whatsappNumber}',
                  whatsAppInfo: WhatsAppInfo(
                      firstName: member.firstName, number: member.whatsappNumber ?? "")),
              BioDetailsCard(title: 'Stream', detail: member.stream.name),
              BioDetailsCard(title: 'Fellowship', detail: member.fellowship.name),
              BioDetailsCard(title: 'Basonta', detail: member.ministry?.name ?? ''),
              const BioDetailsCard(title: 'Holy Ghost Baptism', detail: ''),
              const BioDetailsCard(title: 'Water Baptism', detail: ''),
              const BioDetailsCard(title: 'Notes', detail: ''),
              const BioDetailsCard(title: 'Invited By', detail: ''),
              const BioDetailsCard(title: 'Last Visited', detail: ''),
              const Padding(padding: EdgeInsets.all(8.0)),
              member.pastoralComments == null || member.pastoralComments!.isEmpty
                  ? Container()
                  : Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                        child: Column(
                          children: [
                            Text(
                              'Pastoral Comments',
                              style: PoimenTheme.heading2,
                            ),
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
                            const Padding(padding: EdgeInsets.all(8.0)),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  '/member-pastoral-comments',
                                  arguments: member,
                                );
                              },
                              child: Text(
                                'Show More',
                                style: TextStyle(color: PoimenTheme.brandTextPrimary),
                              ),
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

class BioDetailsCard extends StatelessWidget {
  const BioDetailsCard({
    Key? key,
    required this.title,
    required this.detail,
    this.phoneNumber,
    this.whatsAppInfo,
  }) : super(key: key);

  final String title;
  final String detail;
  final String? phoneNumber;
  final WhatsAppInfo? whatsAppInfo;

  @override
  Widget build(BuildContext context) {
    const titleStyle = TextStyle(fontSize: 15);

    const detailStyle = TextStyle(fontSize: 15, fontWeight: FontWeight.normal);
    if (detail == '') {
      return Container();
    }

    List<Widget> contacts = [];

    if (phoneNumber != null) {
      contacts.add(ContactIcon(
        icon: Icons.phone,
        color: PoimenTheme.phoneColor,
        phoneNumber: phoneNumber,
      ));
    }

    if (whatsAppInfo != null) {
      contacts.add(
        ContactIcon(
          icon: Icons.whatsapp,
          color: PoimenTheme.whatsappColor,
          whatsAppInfo: whatsAppInfo,
        ),
      );
    }

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        title: Text(title, style: titleStyle),
        subtitle: Text(detail, style: detailStyle),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: contacts,
        ),
      ),
    );
  }
}
