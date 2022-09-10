import 'package:flutter/material.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/theme.dart';

class AvatarWithInitials extends StatelessWidget {
  const AvatarWithInitials({
    Key? key,
    required this.foregroundImage,
    required this.member,
    this.radius,
  }) : super(key: key);

  final ImageProvider<Object> foregroundImage;
  final MemberForList member;
  final double? radius;

  computedImage(String url) {
    if (url != '') {
      return foregroundImage;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      foregroundImage: computedImage(member.pictureUrl),
      backgroundColor: PoimenTheme.phoneColor,
      radius: radius ?? 20,
      child: Text(
        member.firstName.substring(0, 1) + member.lastName.substring(0, 1),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
