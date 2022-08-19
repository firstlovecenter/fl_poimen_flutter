import 'package:flutter/material.dart';
import 'package:poimen/screens/profile_choose/models_profile.dart';

class ProfileCard extends StatelessWidget {
  final ProfileChurch church;
  final String level;
  final String? role;
  const ProfileCard(
      {Key? key, required this.church, required this.level, this.role})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '$level $role',
              overflow: TextOverflow.fade,
              softWrap: false,
            ),
            const Padding(padding: EdgeInsets.all(8.0)),
            SizedBox(
              height: 69,
              width: 69,
              child: CircleAvatar(
                foregroundImage: AssetImage(getRoleImmage(level)),
              ),
            ),
            const Padding(padding: EdgeInsets.all(8.0)),
            Text(church.name),
          ],
        ),
      ),
    );
  }
}

getRoleImmage(String level) {
  switch (level) {
    case 'Fellowship':
      return 'assets/images/profile-choose/fellowship-leader.jpg';
    case 'Bacenta':
      return 'assets/images/profile-choose/bacenta-leader.jpg';
    case 'Constituency':
      return 'assets/images/profile-choose/constituency-leader.jpg';
    case 'Council':
      return 'assets/images/profile-choose/council-leader.jpeg';
    case 'Gathering Service':
      return 'assets/images/profile-choose/gathering-admin.jpg';

    default:
  }
}
