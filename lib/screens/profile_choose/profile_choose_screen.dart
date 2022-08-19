import 'package:flutter/material.dart';
import 'package:poimen/screens/profile_choose/models_profile.dart';
import 'package:poimen/screens/profile_choose/profile_card.dart';

class ProfileChooseScreen extends StatelessWidget {
  const ProfileChooseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var profiles = [
      {
        'id': 'asdf-lkhfsdaf',
        'role': 'Bacenta Leader',
        'location': 'New Bortianor'
      }
    ] as List<Profile>;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Choose'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        padding: const EdgeInsets.all(20.0),
        primary: false,
        children:
            profiles.map((profile) => ProfileCard(profile: profile)).toList(),
      ),
    );
  }
}
