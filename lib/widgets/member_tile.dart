import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/services/cloudinary_service.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/avatar_with_initials.dart';
import 'package:poimen/widgets/icon_contact.dart';
import 'package:provider/provider.dart';

Column memberTile(BuildContext context, MemberForList member, [Church? church]) {
  CloudinaryImage picture = CloudinaryImage(url: member.pictureUrl, size: ImageSize.normal);
  var memberState = context.watch<SharedState>();
  var brightness = MediaQuery.of(context).platformBrightness;
  bool isDarkMode = brightness == Brightness.dark;
  Color fellowshipColor = isDarkMode ? Colors.yellow : Colors.yellow.shade900;

  return Column(
    children: [
      Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ListTile(
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
          title:
              Text('${member.firstName} ${member.lastName}', style: const TextStyle(fontSize: 15)),
          subtitle: church != null
              ? Text(
                  '${church.name} ${church.typename}',
                  style:
                      TextStyle(color: church.id == memberState.church.id ? fellowshipColor : null),
                )
              : Text(member.status ?? member.typename),
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
      ),
    ],
  );
}
