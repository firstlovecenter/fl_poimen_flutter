import 'package:flutter/material.dart';
import 'package:poimen/screens/profile_choose/models_profile.dart';
import 'package:poimen/screens/profile_choose/widget_profile_card.dart';
import 'package:poimen/services/auth_service.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/auth_button.dart';

class ProfileChooseWidget extends StatelessWidget {
  const ProfileChooseWidget({
    Key? key,
    required this.user,
  }) : super(key: key);

  final Profile user;

  @override
  Widget build(BuildContext context) {
    // Get the screen size to calculate responsive grid layout
    final screenSize = MediaQuery.of(context).size;

    // Determine crossAxisCount based on screen width
    int crossAxisCount = 2;
    if (screenSize.width > 800) {
      crossAxisCount = 3;
    }
    if (screenSize.width > 1200) {
      crossAxisCount = 4;
    }

    // Calculate maximum card width to prevent oversized cards
    const maxCardWidth = 220.0;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).scaffoldBackgroundColor,
            Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor.withOpacity(0.7),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: PoimenTheme.brand.withOpacity(0.2),
                    foregroundImage: user.pictureUrl != '' ? NetworkImage(user.pictureUrl) : null,
                    child: Text(
                      user.firstName.substring(0, 1) + user.lastName.substring(0, 1),
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: PoimenTheme.brand,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome ',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Text(
                        user.firstName,
                        style: TextStyle(
                          fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
                          fontWeight: FontWeight.bold,
                          color: PoimenTheme.brand,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Which profile would you like to access?',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Calculate how many cards can fit on screen width
                  final cardWidth = constraints.maxWidth / crossAxisCount - 20;
                  final effectiveCardWidth = cardWidth > maxCardWidth ? maxCardWidth : cardWidth;

                  // Create list of all profile options
                  final List<Widget> profileCards = [
                    ...user.leadsBacenta.map((church) {
                      return ProfileCard(
                          church: church, role: 'Leader', maxWidth: effectiveCardWidth);
                    }).toList(),
                    ...user.leadsGovernorship.map((church) {
                      return ProfileCard(
                          church: church, role: 'Leader', maxWidth: effectiveCardWidth);
                    }).toList(),
                    ...user.isAdminForGovernorship.map((church) {
                      return ProfileCard(
                          church: church, role: 'Admin', maxWidth: effectiveCardWidth);
                    }).toList(),
                    ...user.leadsCouncil.map((church) {
                      return ProfileCard(
                          church: church, role: 'Leader', maxWidth: effectiveCardWidth);
                    }).toList(),
                    ...user.isAdminForCouncil.map((church) {
                      return ProfileCard(
                          church: church, role: 'Admin', maxWidth: effectiveCardWidth);
                    }).toList(),
                    ...user.leadsStream.map((church) {
                      return ProfileCard(
                          church: church, role: 'Leader', maxWidth: effectiveCardWidth);
                    }).toList(),
                    ...user.isAdminForStream.map((church) {
                      return ProfileCard(
                          church: church, role: 'Admin', maxWidth: effectiveCardWidth);
                    }).toList(),
                    ...user.leadsCampus.map((church) {
                      return ProfileCard(
                          church: church, role: 'Leader', maxWidth: effectiveCardWidth);
                    }).toList(),
                    ...user.isAdminForCampus.map((church) {
                      return ProfileCard(
                          church: church, role: 'Admin', maxWidth: effectiveCardWidth);
                    }).toList(),
                    ...user.leadsHub.map((church) {
                      return ProfileCard(
                          church: church, role: 'Leader', maxWidth: effectiveCardWidth);
                    }).toList(),
                  ];

                  return Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: GridView.builder(
                        padding: const EdgeInsets.all(15),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 12.0,
                          mainAxisSpacing: 12.0,
                          childAspectRatio: 0.9, // More square-like ratio
                        ),
                        itemCount: profileCards.length,
                        itemBuilder: (context, index) => Center(
                          child: profileCards[index],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: 200,
              child: AuthButton(
                text: 'Sign Out',
                onPressed: () {
                  AuthService.instance.logout(context);
                  Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
                },
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
