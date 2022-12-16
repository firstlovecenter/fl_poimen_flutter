import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:poimen/duties/visitation/models_visitation.dart';
import 'package:poimen/duties/visitation/widget_visitation_report_form.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/services/cloudinary_service.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/avatar_with_initials.dart';
import 'package:poimen/widgets/icon_contact.dart';
import 'package:poimen/widgets/no_data.dart';
import 'package:poimen/widgets/traliing_alert_number.dart';
import 'package:provider/provider.dart';

class ChurchOutstandingVisitationList extends StatelessWidget {
  const ChurchOutstandingVisitationList({Key? key, required this.church}) : super(key: key);

  final ChurchForOutstandingVisitationList church;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(children: [
        const Padding(padding: EdgeInsets.all(10)),
        const Text(
          'These people have not been visited during the current sheperding cycle',
          style: TextStyle(fontSize: 16),
        ),
        // a centered card with the number of outstanding visitations
        const Padding(padding: EdgeInsets.all(10)),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(FontAwesomeIcons.doorOpen),
                  trailing: TrailingCardAlertNumber(
                      number: church.outstandingVisitations.length,
                      variant: TrailingCardAlertNumberVariant.red),
                  title: const Text('Visits Remaining'),
                ),
              ],
            ),
          ),
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(
                    FontAwesomeIcons.solidThumbsUp,
                    color: Colors.green,
                  ),
                  trailing: TrailingCardAlertNumber(
                    number: church.completedVisitationsCount,
                    variant: TrailingCardAlertNumberVariant.green,
                  ),
                  title: const Text('Visits Completed'),
                ),
              ],
            ),
          ),
        ),
        const Padding(padding: EdgeInsets.all(8.0)),
        ...noDataChecker(church.outstandingVisitations.map((member) {
          return _memberTile(context, member);
        }).toList()),
      ]),
    );
  }
}

Column _memberTile(BuildContext context, OutstandingVisitationForList member) {
  CloudinaryImage picture = CloudinaryImage(url: member.pictureUrl, size: ImageSize.normal);
  var memberState = Provider.of<SharedState>(context);

  return Column(
    children: [
      Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  memberState.memberId = member.id;
                  memberState.member = member;
                  Navigator.pushNamed(context, '/member-details');
                },
                leading: Hero(
                  tag: 'member-${member.id}',
                  child: AvatarWithInitials(
                    foregroundImage: picture.image,
                    member: member,
                  ),
                ),
                title: Text('${member.firstName} ${member.lastName}'),
                subtitle: Text(member.status!),
                trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                  ContactIcon(
                    icon: Icons.phone,
                    color: PoimenTheme.phoneColor,
                    phoneNumber: member.phoneNumber,
                  ),
                  ContactIcon(
                    icon: FontAwesomeIcons.whatsapp,
                    color: PoimenTheme.whatsappColor,
                    whatsAppInfo: WhatsAppInfo(
                        number: member.whatsappNumber ?? '', firstName: member.firstName),
                  ),
                ]),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  _bottomSheet(context, member);
                },
                style: _outstandingVisitationButtonStyle(),
                icon: const Icon(
                  FontAwesomeIcons.pencil,
                  size: 15,
                ),
                label: const Text('Record Visit'),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

ButtonStyle _outstandingVisitationButtonStyle() {
  return ButtonStyle(
    padding: MaterialStateProperty.all(
      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    ),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  );
}

_bottomSheet(BuildContext context, MemberForList member) {
  showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return OutstandingVisitationReportForm(member: member);
      });
}
