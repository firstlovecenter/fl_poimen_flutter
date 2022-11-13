import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:poimen/services/cloudinary_service.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/avatar_with_initials.dart';
import 'package:poimen/widgets/color_block_tile.dart';
import 'package:provider/provider.dart';

class MembershipUpgradesScreen extends StatelessWidget {
  const MembershipUpgradesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<SharedState>(context);
    final member = state.member;
    final memberPicture = CloudinaryImage(url: member.pictureUrl, size: ImageSize.normal);

    return Scaffold(
      appBar: AppBar(title: const Text("Membership Upgrades")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(children: [
          const Padding(padding: EdgeInsets.all(15)),
          Row(
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
                    foregroundImage: memberPicture.image,
                    member: member,
                    radius: 45,
                  ),
                ],
              )
            ],
          ),
          const Padding(padding: EdgeInsets.all(15.0)),
          ColorBlockTile(
            leadingColor: const Color(0xFF1C4AC0),
            icon: FontAwesomeIcons.wind,
            title: 'Holy Ghost Baptism',
          ),
          const Padding(padding: EdgeInsets.all(8.0)),
          ColorBlockTile(
            leadingColor: const Color(0xFF330045),
            icon: FontAwesomeIcons.water,
            title: 'Water Baptism',
          ),
          const Padding(padding: EdgeInsets.all(8.0)),
          ColorBlockTile(
            leadingColor: const Color(0xFF000745),
            icon: FontAwesomeIcons.school,
            title: 'Understanding Campaign',
          ),
          const Padding(padding: EdgeInsets.all(8.0)),
          ColorBlockTile(
            leadingColor: const Color(0xFF00450F),
            icon: FontAwesomeIcons.tent,
            title: 'Camps with the Prophet',
          ),
          const Padding(padding: EdgeInsets.all(8.0)),
          ColorBlockTile(
            leadingColor: const Color(0xFF00450F),
            icon: FontAwesomeIcons.tents,
            title: 'Camps with Other Bishops',
          ),
          const Padding(padding: EdgeInsets.all(8.0)),
          ColorBlockTile(
            leadingColor: const Color(0xFF452E00),
            icon: FontAwesomeIcons.music,
            title: 'Audio Collections',
          ),
          const Padding(padding: EdgeInsets.all(8.0)),
          ColorBlockTile(
            leadingColor: const Color(0xFF003445),
            icon: FontAwesomeIcons.book,
            title: 'Bible Translations',
          ),
        ]),
      ),
    );
  }
}
