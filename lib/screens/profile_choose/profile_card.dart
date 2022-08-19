import 'package:flutter/material.dart';
import 'package:poimen/screens/profile_choose/models_profile.dart';

class ProfileCard extends StatelessWidget {
  final Profile profile;
  const ProfileCard({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(profile.role),
          Text(profile.location),
        ],
      ),
    );
  }
}
