import 'package:flutter/material.dart';
import 'package:poimen/screens/profile_choose/models_profile.dart';
import 'package:poimen/screens/profile_choose/widget_profile_card.dart';
import 'package:poimen/services/auth_service.dart';
import 'package:poimen/widgets/auth_button.dart';

class ProfileChooseWidget extends StatelessWidget {
  const ProfileChooseWidget({
    Key? key,
    required this.user,
  }) : super(key: key);

  final Profile user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(padding: EdgeInsets.all(20)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome ',
                style: Theme.of(context).textTheme.headline5,
              ),
              Text(
                user.firstName,
                style: Theme.of(context).textTheme.headline6,
              )
            ],
          ),
          const Text('Which profile would you like to access?'),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              children: [
                ...user.leadsFellowship.map((church) {
                  return ProfileCard(church: church, role: 'Leader');
                }).toList(),
                ...user.leadsBacenta.map((church) {
                  return ProfileCard(church: church, role: 'Leader');
                }).toList(),
                ...user.leadsConstituency.map((church) {
                  return ProfileCard(church: church, role: 'Leader');
                }).toList(),
                ...user.leadsCouncil.map((church) {
                  return ProfileCard(church: church, role: 'Leader');
                }).toList(),
                ...user.leadsStream.map((church) {
                  return ProfileCard(church: church, role: 'Leader');
                }).toList(),
                ...user.leadsGatheringService.map((church) {
                  return ProfileCard(church: church, role: 'Leader');
                }).toList(),
                ...user.isAdminForGatheringService.map((church) {
                  return ProfileCard(church: church, role: 'Admin');
                }).toList(),
              ],
            ),
          ),
          AuthButton(
              text: 'Sign Out',
              onPressed: () {
                AuthService.instance.logout();
                Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
              }),
          const Padding(padding: EdgeInsets.all(6))
        ],
      ),
    );
  }
}
