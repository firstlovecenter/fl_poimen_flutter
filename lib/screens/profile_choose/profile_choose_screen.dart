import 'package:flutter/material.dart';

class Profile {
  String role;
  String location;

  Profile(this.role, this.location);
}

class ProfileChooseScreen extends StatelessWidget {
  const ProfileChooseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var profiles = [
      Profile('Bacenta Leader', 'Bortianor'),
      Profile('Fellowship Leader', 'Las Vegas')
    ];

    return Scaffold(
      appBar: AppBar(),
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        padding: const EdgeInsets.all(20.0),
        primary: false,
        children: profiles.map((profile) => Text(profile.role)).toList(),
      ),
    );
  }
}
