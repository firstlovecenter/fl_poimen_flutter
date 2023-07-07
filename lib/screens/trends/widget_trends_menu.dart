import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:poimen/screens/home/widget_home_page_button.dart';
import 'package:poimen/screens/trends/models_trends.dart';
import 'package:poimen/state/enums.dart';
import 'package:poimen/widgets/user_header_widget.dart';

class WidgetTrendsMenu extends StatelessWidget {
  const WidgetTrendsMenu({Key? key, required this.church, required this.permittedRoles})
      : super(key: key);

  final ChurchForTrendsMenu church;
  final List<Role> permittedRoles;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          const UserHeaderWidget(),
          const Padding(padding: EdgeInsets.all(16.0)),
          HomePageButton(
            text: 'Pastoral Work',
            icon: FontAwesomeIcons.solidClock,
            route: '/trends/fellowship/pastoral-work',
            navKey: 'fellowshipPastoralWork',
            permitted: permittedRoles,
            navigateBack: true,
          ),
          const Padding(padding: EdgeInsets.all(4.0)),
          HomePageButton(
            text: 'Membership Attendance',
            icon: FontAwesomeIcons.userCheck,
            route: '/trends/fellowship/membership-attendance',
            navKey: 'fellowshipMembershipAttendance',
            permitted: permittedRoles,
            navigateBack: true,
          ),
        ],
      ),
    );
  }
}
