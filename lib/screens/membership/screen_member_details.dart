import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:poimen/screens/membership/gql_member_details.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/services/cloudinary_service.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/avatar_with_initials.dart';
import 'package:poimen/widgets/gql_query_container.dart';
import 'package:poimen/widgets/icon_contact.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

class MemberDetailsScreen extends StatelessWidget {
  const MemberDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<SharedState>(context);

    return GQLQueryContainer(
      query: getMemberDetails,
      variables: {'id': state.memberId},
      defaultPageTitle: 'Member Details',
      bodyFunction: (data) {
        final member = Member.fromJson(data?['members'][0]);
        final picture = CloudinaryImage(url: member.pictureUrl, size: ImageSize.lg);
        const headerStyle = TextStyle(
          color: Color(0xffffffff),
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
              Center(
                  child: Text(
                '${member.firstName} ${member.lastName}',
                style: headerStyle,
              )),
              const Padding(padding: EdgeInsets.all(8.0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...member.lastFourServices.map((present) {
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
    const titleStyle = TextStyle(color: Color(0xffffffff), fontSize: 15);

    const detailStyle =
        TextStyle(color: Color(0x88ffffff), fontSize: 15, fontWeight: FontWeight.normal);
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
