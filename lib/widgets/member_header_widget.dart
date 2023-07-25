import 'package:flutter/material.dart';
import 'package:poimen/screens/home/utils_home.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/services/cloudinary_service.dart';
import 'package:poimen/state/enums.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/avatar_with_initials.dart';

class MemberHeaderWidget extends StatelessWidget {
  const MemberHeaderWidget({
    Key? key,
    required this.member,
    required this.role,
    this.secondaryHeading,
    this.avatarRadius,
  }) : super(key: key);

  final MemberForList member;
  final Role role;
  final String? secondaryHeading;
  final double? avatarRadius;

  @override
  Widget build(BuildContext context) {
    final picture = CloudinaryImage(url: member.pictureUrl, size: ImageSize.lg);
    var memberRole = parseRole(role);

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
              secondaryHeading ?? memberRole,
              style: const TextStyle(color: PoimenTheme.textSecondary),
            )
          ],
        ),
        const Padding(padding: EdgeInsets.all(10.0)),
        AvatarWithInitials(
          foregroundImage: picture.image,
          member: member,
          radius: avatarRadius ?? 45,
        )
      ],
    );
  }
}
