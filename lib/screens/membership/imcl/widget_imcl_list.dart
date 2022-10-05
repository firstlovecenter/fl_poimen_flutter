import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:poimen/screens/membership/imcl/models_imcl.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/services/cloudinary_service.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/avatar_with_initials.dart';
import 'package:poimen/widgets/icon_contact.dart';
import 'package:poimen/widgets/no_data.dart';
import 'package:provider/provider.dart';

class ChurchImclList extends StatelessWidget {
  const ChurchImclList({Key? key, required this.church}) : super(key: key);

  final ChurchForImclList church;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(children: [
        const Padding(padding: EdgeInsets.all(10)),
        const Text(
          'This is the list of those who were not at the last church service',
          style: TextStyle(fontSize: 16),
        ),
        Center(
          child: Text(
            'You must contact them to find out why they were absent',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: PoimenTheme.brand),
          ),
        ),
        const Padding(padding: EdgeInsets.all(8.0)),
        ...noDataChecker(church.imcls.map((member) {
          return _memberTile(context, member);
        }).toList()),
      ]),
    );
  }
}

Column _memberTile(BuildContext context, MemberForList member) {
  CloudinaryImage picture = CloudinaryImage(url: member.pictureUrl, size: ImageSize.normal);
  var memberState = Provider.of<SharedState>(context);

  return Column(
    children: [
      Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ListTile(
          onTap: () {
            memberState.memberId = member.id;
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
                  WhatsAppInfo(number: member.whatsappNumber ?? '', firstName: member.firstName),
            ),
          ]),
        ),
      ),
    ],
  );
}
