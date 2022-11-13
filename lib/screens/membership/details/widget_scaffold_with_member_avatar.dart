import 'package:flutter/material.dart';
import 'package:poimen/screens/membership/details/widget_member_avatar_screen_header.dart';
import 'package:poimen/services/cloudinary_service.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:provider/provider.dart';

class ScaffoldWithMemberAvatar extends StatelessWidget {
  const ScaffoldWithMemberAvatar({
    Key? key,
    required this.children,
    required this.title,
  }) : super(key: key);

  final List<Widget> children;
  final String title;

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<SharedState>(context);
    final member = state.member;
    final memberPicture = CloudinaryImage(url: member.pictureUrl, size: ImageSize.normal);

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(children: [
          const Padding(padding: EdgeInsets.all(15)),
          MemberAvatarScreenHeader(member: member, memberPicture: memberPicture),
          const Padding(padding: EdgeInsets.all(15.0)),
          ...children,
        ]),
      ),
    );
  }
}
