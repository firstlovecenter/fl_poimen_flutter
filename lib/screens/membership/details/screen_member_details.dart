import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:poimen/helpers/menus.dart';
import 'package:poimen/screens/membership/details/gql_member_details.dart';
import 'package:poimen/screens/membership/details/screen_member_pastoral_comments.dart';
import 'package:poimen/screens/membership/details/widget_save_contact.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/services/cloudinary_service.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/avatar_with_initials.dart';
import 'package:poimen/services/gql_query_container.dart';
import 'package:poimen/widgets/bottom_nav_bar.dart';
import 'package:poimen/widgets/icon_contact.dart';
import 'package:poimen/widgets/member_status_chip.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

class MemberDetailsScreen extends StatelessWidget {
  const MemberDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = context.watch<SharedState>();

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

        DateFormat formatter = DateFormat('yMMMEd');
        String lastAttendedServiceDate = member.lastAttendedServiceDate != null
            ? formatter.format(DateTime.parse(member.lastAttendedServiceDate.toString()))
            : '';
        // END: ed8c6549bwf9;

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
              MemberStatusChip(member: member),
              Center(
                child: Text(
                  '${member.firstName} ${member.lastName}',
                  style: headerStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              const Padding(padding: EdgeInsets.all(8.0)),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Column(
                  children: [
                    member.lastAttendedServiceDate != null
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Last Attended On: '),
                                Text(
                                  lastAttendedServiceDate,
                                  style: TextStyle(
                                    color: PoimenTheme.brand,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                )
                              ],
                            ),
                          )
                        : Container(),
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      const WeekendCard(
                        text: 'WEEKDAY',
                      ),
                      ...member.lastFourWeekdayServices.map((service) {
                        return Row(
                          children: [
                            service.present
                                ? Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: CircleAvatar(
                                      backgroundColor:
                                          service.present ? PoimenTheme.good : PoimenTheme.bad,
                                      radius: 15,
                                      child: Icon(
                                        service.present
                                            ? FontAwesomeIcons.check
                                            : FontAwesomeIcons.xmark,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                : const Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(4.0),
                                        child: CircleAvatar(
                                          backgroundColor: Colors.red,
                                          radius: 15,
                                          child: Icon(
                                            FontAwesomeIcons.xmark,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                          ],
                        );
                      }),
                    ]),
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      const WeekendCard(
                        text: 'WEEKEND',
                      ),
                      ...member.lastFourWeekendServices.map((service) {
                        return Row(
                          children: [
                            service.present
                                ? Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: CircleAvatar(
                                      backgroundColor:
                                          service.present ? PoimenTheme.good : PoimenTheme.bad,
                                      radius: 15,
                                      child: Icon(
                                        service.present
                                            ? FontAwesomeIcons.check
                                            : FontAwesomeIcons.xmark,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                : const Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(4.0),
                                        child: CircleAvatar(
                                          backgroundColor: Colors.red,
                                          radius: 15,
                                          child: Icon(
                                            FontAwesomeIcons.xmark,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                          ],
                        );
                      }),
                    ]),
                  ],
                ),
              ),
              const Padding(padding: EdgeInsets.all(8.0)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    tileColor: PoimenTheme.brand,
                    leading: const Icon(
                      FontAwesomeIcons.book,
                      color: Colors.white,
                    ),
                    title: const Text(
                      'Spiritual Progression',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/member-spiritual-progression');
                    }),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    tileColor: PoimenTheme.brand,
                    leading: const Icon(
                      FontAwesomeIcons.baby,
                      color: Colors.white,
                    ),
                    title: const Text(
                      'Life Progression',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/member-life-progression');
                    }),
              ),
              const Padding(padding: EdgeInsets.all(8.0)),
              const Padding(padding: EdgeInsets.all(8.0)),
              Text(
                'Bio Data',
                style: PoimenTheme.heading2,
              ),
              BioDetailsCard(title: 'First Name', detail: member.firstName),
              BioDetailsCard(title: 'Middle Name', detail: member.middleName),
              BioDetailsCard(title: 'Last Name', detail: member.lastName),
              BioDetailsCard(title: 'Sex', detail: member.gender.gender.name),
              BioDetailsCard(title: 'Date of Birth', detail: member.dob.humanReadable),
              const Padding(padding: EdgeInsets.all(8.0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Contact Information',
                    style: PoimenTheme.heading2,
                  ),
                  WidgetSaveContact(member: member, roles: ''),
                ],
              ),
              BioDetailsCard(
                  title: 'Phone Number',
                  detail: '+${member.phoneNumber}',
                  phoneNumber: member.phoneNumber),
              BioDetailsCard(
                  title: 'Whatsapp Number',
                  detail: '+${member.whatsappNumber}',
                  whatsAppInfo:
                      WhatsAppInfo(firstName: member.firstName, number: member.whatsappNumber)),
              const Padding(padding: EdgeInsets.all(8.0)),
              Text(
                'Church Information',
                style: PoimenTheme.heading2,
              ),
              BioDetailsCard(title: 'Council', detail: member.council.name),
              BioDetailsCard(title: 'Bacenta', detail: member.bacenta.name),
              if (member.bacenta.leader != null && member.bacenta.leader!.id != member.id)
                InkWell(
                  onTap: () {
                    state.memberId = member.bacenta.leader!.id;
                    Navigator.pushNamed(
                      context,
                      '/member-details',
                      arguments: member.bacenta.leader,
                    );
                  },
                  child: BioDetailsCard(
                      title: 'Bacenta Leader',
                      detail:
                          '${member.bacenta.leader!.firstName} ${member.bacenta.leader!.lastName}',
                      phoneNumber: member.bacenta.leader!.phoneNumber,
                      whatsAppInfo: WhatsAppInfo(
                          firstName: member.bacenta.leader!.firstName,
                          number: member.bacenta.leader!.whatsappNumber)),
                )
              else
                Container(),
              BioDetailsCard(title: 'Ministry', detail: member.ministry?.name ?? ''),
              BioDetailsCard(title: 'Visitation Area', detail: member.visitationArea),
              const BioDetailsCard(title: 'Last Visited', detail: ''),
              const BioDetailsCard(title: 'Notes', detail: ''),
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
                                  return PastoralCommentCard(comment: comment);
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

class WeekendCard extends StatelessWidget {
  const WeekendCard({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return Card(
        color: isDarkMode ? Colors.grey[800] : Colors.grey[300],
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Text(text),
        ));
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
          icon: FontAwesomeIcons.whatsapp,
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
