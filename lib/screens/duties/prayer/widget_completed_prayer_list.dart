import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:poimen/screens/duties/prayer/models_prayer.dart';
import 'package:poimen/services/cloudinary_service.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/avatar_with_initials.dart';
import 'package:poimen/widgets/icon_contact.dart';
import 'package:poimen/widgets/no_data.dart';
import 'package:poimen/widgets/traliing_alert_number.dart';
import 'package:provider/provider.dart';

class ChurchCompletedPrayerList extends StatelessWidget {
  const ChurchCompletedPrayerList({Key? key, required this.church}) : super(key: key);

  final ChurchForCompletedPrayerList church;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(children: [
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
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/${church.typename.toLowerCase()}/outstanding-prayer',
                    );
                  },
                  leading: const Icon(FontAwesomeIcons.phone),
                  trailing: TrailingCardAlertNumber(
                      number: church.outstandingPrayerCount,
                      variant: TrailingCardAlertNumberVariant.red),
                  title: const Text('Prayers Remaining'),
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
                    number: church.completedPrayers.length,
                    variant: TrailingCardAlertNumberVariant.green,
                  ),
                  title: const Text('Prayers Completed'),
                ),
              ],
            ),
          ),
        ),
        const Padding(padding: EdgeInsets.all(8.0)),
        ...noDataChecker(church.completedPrayers.map((member) {
          return _memberTile(context, member);
        }).toList()),
      ]),
    );
  }
}

Column _memberTile(BuildContext context, CompletedPrayerForList member) {
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
                    whatsAppInfo:
                        WhatsAppInfo(number: member.whatsappNumber, firstName: member.firstName),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
