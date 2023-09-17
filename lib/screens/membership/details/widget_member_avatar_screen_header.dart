import 'package:flutter/material.dart';
import 'package:poimen/services/cloudinary_service.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/avatar_with_initials.dart';
import 'package:poimen/screens/membership/models_membership.dart';

class MemberAvatarScreenHeader extends StatelessWidget {
  const MemberAvatarScreenHeader({
    Key? key,
    required this.member,
    required this.memberPicture,
  }) : super(key: key);

  final MemberForList member;
  final CloudinaryImage memberPicture;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${member.firstName} ${member.lastName}',
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              member.status ?? member.typename,
              style: const TextStyle(color: PoimenTheme.textSecondary),
            )
          ],
        ),
        const Padding(padding: EdgeInsets.all(10.0)),
        Column(
          children: [
            AvatarWithInitials(
              show: true,
              foregroundImage: memberPicture.image,
              member: member,
              radius: 45,
            ),
          ],
        )
      ],
    );
  }
}
