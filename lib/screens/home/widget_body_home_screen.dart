import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:poimen/screens/home/models_home_screen.dart';
import 'package:poimen/screens/home/utils_home.dart';
import 'package:poimen/screens/home/widget_home_page_button.dart';
import 'package:poimen/state/enums.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/user_header_widget.dart';
import 'package:provider/provider.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({
    Key? key,
    required this.church,
  }) : super(key: key);

  final HomeScreenChurch church;

  @override
  Widget build(BuildContext context) {
    final churchState = context.watch<SharedState>();
    String level = church.typename.toLowerCase();
    final churchLevel = convertToChurchEnum(level);
    final levelForUrl = churchLevel.name.toLowerCase();
    final size = MediaQuery.of(context).size;
    final isTabletOrLarger = size.width > 600;
    final isDesktop = size.width > 1100;

    // Calculate responsive padding
    final horizontalPadding = size.width * 0.05; // 5% of screen width
    final verticalPadding = size.height * 0.02; // 2% of screen height

    // Set data in the church state for other screens
    Future.delayed(Duration.zero, () {
      if (church.currentPastoralCycle != null) {
        churchState.pastoralCycle = church.currentPastoralCycle!;
      }
    });

    int? totalFellowshipAttendanceDefaulters;

    if (church.fellowshipBussingAttendanceDefaultersCount != null &&
        church.fellowshipServiceAttendanceDefaultersCount != null) {
      totalFellowshipAttendanceDefaulters = church.fellowshipBussingAttendanceDefaultersCount! +
          church.fellowshipServiceAttendanceDefaultersCount!;
    }

    // Build section cards for better organization
    Widget buildSectionCard({
      required String title,
      required List<Widget> children,
      Color? iconColor,
      IconData? icon,
    }) {
      return Card(
        elevation: 2,
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: isTabletOrLarger ? 4 : 0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (icon != null) Icon(icon, color: iconColor ?? PoimenTheme.brand, size: 20),
                  if (icon != null) const SizedBox(width: 8),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: PoimenTheme.textSecondary,
                    ),
                  ),
                ],
              ),
              const Divider(),
              ...children,
            ],
          ),
        ),
      );
    }

    // Create the responsive layout
    Widget buildResponsiveLayout() {
      if (isDesktop) {
        // Three-column layout for large screens
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  // Reports section
                  buildSectionCard(
                    title: 'Reports',
                    icon: FontAwesomeIcons.chartLine,
                    children: [
                      ...attendanceLevels(churchLevel),
                      ...hubAttendanceLevels(churchLevel),
                      HomePageButton(
                        text: 'Membership List',
                        navKey: 'membership',
                        icon: FontAwesomeIcons.solidAddressBook,
                        route: '/$levelForUrl-members',
                        permitted: const [Role.all],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  // Outstanding Work section
                  buildSectionCard(
                    title: 'Outstanding Work',
                    icon: FontAwesomeIcons.clipboardCheck,
                    iconColor: Colors.orange,
                    children: [
                      defaultersLevels(churchLevel, totalFellowshipAttendanceDefaulters),
                      HomePageButton(
                        text: 'Missing Persons Call List',
                        icon: FontAwesomeIcons.personCircleQuestion,
                        navKey: 'imcls',
                        route: '/$levelForUrl-imcls',
                        alertNumber: church.imclTotal,
                        permitted: const [
                          Role.leaderFellowship,
                          Role.leaderBacenta,
                          Role.leaderGovernorship,
                          Role.adminGovernorship,
                          Role.leaderHub
                        ],
                      ),
                      imclLevels(churchLevel, church.imclTotal),
                      outstandingTelepastoringLevels(
                          churchLevel, church.outstandingTelepastoringCount),
                      outstandingVisitationLevels(churchLevel, church.outstandingVisitationsCount),
                      outstandingPrayerLevels(churchLevel, church.outstandingPrayerCount),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  // Trends section
                  buildSectionCard(
                    title: 'Trends',
                    icon: FontAwesomeIcons.chartSimple,
                    iconColor: Colors.green,
                    children: [
                      HomePageButton(
                        text: 'My Trends',
                        icon: FontAwesomeIcons.chartSimple,
                        route: '/$levelForUrl-trends-menu',
                        navKey: 'trends',
                        permitted: const [Role.all],
                      ),
                      myLeadersTrendsLevels(churchLevel),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      } else if (isTabletOrLarger) {
        // Two-column layout for tablets
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  // Reports section
                  buildSectionCard(
                    title: 'Reports',
                    icon: FontAwesomeIcons.chartLine,
                    children: [
                      ...attendanceLevels(churchLevel),
                      ...hubAttendanceLevels(churchLevel),
                      HomePageButton(
                        text: 'Membership List',
                        navKey: 'membership',
                        icon: FontAwesomeIcons.solidAddressBook,
                        route: '/$levelForUrl-members',
                        permitted: const [Role.all],
                      ),
                    ],
                  ),
                  // Trends section
                  buildSectionCard(
                    title: 'Trends',
                    icon: FontAwesomeIcons.chartSimple,
                    iconColor: Colors.green,
                    children: [
                      HomePageButton(
                        text: 'My Trends',
                        icon: FontAwesomeIcons.chartSimple,
                        route: '/$levelForUrl-trends-menu',
                        navKey: 'trends',
                        permitted: const [Role.all],
                      ),
                      myLeadersTrendsLevels(churchLevel),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  // Outstanding Work section
                  buildSectionCard(
                    title: 'Outstanding Work',
                    icon: FontAwesomeIcons.clipboardCheck,
                    iconColor: Colors.orange,
                    children: [
                      defaultersLevels(churchLevel, totalFellowshipAttendanceDefaulters),
                      HomePageButton(
                        text: 'Missing Persons Call List',
                        icon: FontAwesomeIcons.personCircleQuestion,
                        navKey: 'imcls',
                        route: '/$levelForUrl-imcls',
                        alertNumber: church.imclTotal,
                        permitted: const [
                          Role.leaderFellowship,
                          Role.leaderBacenta,
                          Role.leaderGovernorship,
                          Role.adminGovernorship,
                          Role.leaderHub
                        ],
                      ),
                      imclLevels(churchLevel, church.imclTotal),
                      outstandingTelepastoringLevels(
                          churchLevel, church.outstandingTelepastoringCount),
                      outstandingVisitationLevels(churchLevel, church.outstandingVisitationsCount),
                      outstandingPrayerLevels(churchLevel, church.outstandingPrayerCount),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      } else {
        // Single column for mobile
        return Column(
          children: [
            // Reports section
            buildSectionCard(
              title: 'Reports',
              icon: FontAwesomeIcons.chartLine,
              children: [
                ...attendanceLevels(churchLevel),
                ...hubAttendanceLevels(churchLevel),
                HomePageButton(
                  text: 'Membership List',
                  navKey: 'membership',
                  icon: FontAwesomeIcons.solidAddressBook,
                  route: '/$levelForUrl-members',
                  permitted: const [Role.all],
                ),
              ],
            ),
            // Outstanding Work section
            buildSectionCard(
              title: 'Outstanding Work',
              icon: FontAwesomeIcons.clipboardCheck,
              iconColor: Colors.orange,
              children: [
                defaultersLevels(churchLevel, totalFellowshipAttendanceDefaulters),
                HomePageButton(
                  text: 'Missing Persons Call List',
                  icon: FontAwesomeIcons.personCircleQuestion,
                  navKey: 'imcls',
                  route: '/$levelForUrl-imcls',
                  alertNumber: church.imclTotal,
                  permitted: const [
                    Role.leaderFellowship,
                    Role.leaderBacenta,
                    Role.leaderGovernorship,
                    Role.adminGovernorship,
                    Role.leaderHub
                  ],
                ),
                imclLevels(churchLevel, church.imclTotal),
                outstandingTelepastoringLevels(churchLevel, church.outstandingTelepastoringCount),
                outstandingVisitationLevels(churchLevel, church.outstandingVisitationsCount),
                outstandingPrayerLevels(churchLevel, church.outstandingPrayerCount),
              ],
            ),
            // Trends section
            buildSectionCard(
              title: 'Trends',
              icon: FontAwesomeIcons.chartSimple,
              iconColor: Colors.green,
              children: [
                HomePageButton(
                  text: 'My Trends',
                  icon: FontAwesomeIcons.chartSimple,
                  route: '/$levelForUrl-trends-menu',
                  navKey: 'trends',
                  permitted: const [Role.all],
                ),
                myLeadersTrendsLevels(churchLevel),
              ],
            ),
          ],
        );
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
          child: RefreshIndicator(
            onRefresh: () async {
              // Implement refresh functionality here if needed
              await Future.delayed(const Duration(milliseconds: 1500));
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // User header with shadow and rounded corners
                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          const UserHeaderWidget(),
                          Column(
                            children: countdownLevels(church),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Text(
                              '${church.name} ${church.typename}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Main content with responsive layout
                  buildResponsiveLayout(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
