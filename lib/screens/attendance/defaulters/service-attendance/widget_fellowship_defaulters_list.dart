import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:poimen/screens/attendance/defaulters/models_defaulters.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/services/cloudinary_service.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/avatar_with_initials.dart';
import 'package:poimen/widgets/icon_contact.dart';
import 'package:poimen/widgets/no_data.dart';

class FellowshipAttendanceDefaultersList extends StatelessWidget {
  const FellowshipAttendanceDefaultersList({Key? key, required this.church}) : super(key: key);

  final ChurchForServiceAttendanceDefaultersList church;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          const Padding(padding: EdgeInsets.all(16.0)),
          const Center(
            child: Text(
              "Did Not Fill Fellowship Attendance",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.all(16.0)),
          ...noDataChecker(
            church.fellowshipServiceAttendanceDefaulters.map((fellowship) {
              return _showAttendanceDefaultersList(fellowship);
            }).toList(),
          ),
        ],
      ),
    );
  }
}

Column _showAttendanceDefaultersList(Church church) {
  if (church.leader == null) {
    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: ListTile(
            title: Text('${church.name} ${church.typename}'),
            subtitle: const Text('No leader'),
          ),
        ),
      ],
    );
  }

  final leader = church.leader as MemberForList;

  CloudinaryImage picture = CloudinaryImage(url: leader.pictureUrl);

  return Column(
    children: [
      Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ListTile(
          onTap: () {},
          leading: Hero(
            tag: 'member-${leader.id}',
            child: AvatarWithInitials(foregroundImage: picture.image, member: leader),
          ),
          title: Text('${church.name} ${church.typename}'),
          subtitle: Text('${leader.firstName} ${leader.lastName}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ContactIcon(
                icon: Icons.phone,
                color: PoimenTheme.phoneColor,
                phoneNumber: leader.phoneNumber,
              ),
              ContactIcon(
                icon: FontAwesomeIcons.whatsapp,
                color: PoimenTheme.whatsappColor,
                whatsAppInfo:
                    WhatsAppInfo(number: leader.whatsappNumber, firstName: leader.firstName),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
