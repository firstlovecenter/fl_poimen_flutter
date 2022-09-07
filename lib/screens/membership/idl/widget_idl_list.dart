import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:poimen/screens/membership/idl/models_idl.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/services/cloudinary_service.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/no_data.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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

class ContactIcon extends StatelessWidget {
  const ContactIcon({
    Key? key,
    required this.icon,
    required this.color,
    this.phoneNumber,
    this.whatsappNumber,
  }) : super(key: key);

  final IconData icon;
  final Color color;
  final String? phoneNumber;
  final String? whatsappNumber;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      child: CircleAvatar(
        backgroundColor: color,
        child: IconButton(
          onPressed: () async {
            if (whatsappNumber != null) {
              await _sendWhatsappMessage(whatsappNumber);
            } else if (phoneNumber != null) {
              await _makePhoneCall(phoneNumber);
            }

            return;
          },
          icon: Icon(
            icon,
            color: Colors.black,
          ),
          iconSize: 20,
        ),
      ),
    );
  }
}

Future<void> _makePhoneCall(String? phoneNumber) async {
  if (phoneNumber == null) {
    return;
  }
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );

  if (await canLaunchUrl(launchUri)) {
    await launchUrl(launchUri);
  } else {
    throw 'Could not launch $launchUri';
  }

  await launchUrl(launchUri);
}

Future<void> _sendWhatsappMessage(String? whatsappNumber) async {
  if (whatsappNumber == null) {
    return;
  }
  final Uri launchUri = Uri(
    scheme: 'https',
    path: 'wa.me/$whatsappNumber',
  );

  if (await canLaunchUrl(launchUri)) {
    await launchUrl(launchUri);
  } else {
    throw 'Could not launch $launchUri';
  }

  await launchUrl(launchUri);
}
