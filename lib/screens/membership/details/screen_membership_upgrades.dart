import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:poimen/widgets/color_block_tile.dart';

class MembershipUpgradesScreen extends StatelessWidget {
  const MembershipUpgradesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Membership Upgrades")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(children: [
          const Padding(padding: EdgeInsets.all(15)),
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
