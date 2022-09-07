import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:poimen/screens/membership/idl/models_idl.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/services/cloudinary_service.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/icon_contact.dart';
import 'package:poimen/widgets/no_data.dart';
import 'package:provider/provider.dart';

class ChurchIdlList extends StatelessWidget {
  const ChurchIdlList({Key? key, required this.church}) : super(key: key);

  final ChurchForIdlList church;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(
        children: noDataChecker(church.idls.map((member) {
          return _memberTile(context, member);
        }).toList()),
      ),
    );
  }
}

Column _memberTile(BuildContext context, MemberForList member) {
  CloudinaryImage picture = CloudinaryImage(url: member.pictureUrl, size: ImageSize.normal);
  var memberState = Provider.of<SharedState>(context);

  return Column(
    children: [
      Card(
        child: ListTile(
          onTap: () {
            memberState.memberId = member.id;
            Navigator.pushNamed(context, '/member-details');
          },
          leading: Hero(
            tag: 'member-${member.id}',
            child: CircleAvatar(
              foregroundImage: NetworkImage(picture.url),
              child: Text(
                member.firstName.substring(0, 1) + member.lastName.substring(0, 1),
              ),
            ),
          ),
          title: Text('${member.firstName} ${member.lastName}'),
          subtitle: Text(member.typename),
          trailing: Row(mainAxisSize: MainAxisSize.min, children: [
            ContactIcon(
              icon: Icons.phone,
              color: PoimenTheme.phoneColor,
              phoneNumber: member.phoneNumber,
            ),
            ContactIcon(
              icon: FontAwesomeIcons.whatsapp,
              color: PoimenTheme.whatsappColor,
              whatsappNumber: member.whatsappNumber,
            ),
          ]),
        ),
      ),
    ],
  );
}
