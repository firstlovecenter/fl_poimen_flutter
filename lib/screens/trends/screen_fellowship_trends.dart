import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:poimen/screens/home/widget_home_page_button.dart';
import 'package:poimen/screens/trends/gql_trends.dart';
import 'package:poimen/screens/trends/models_trends.dart';
import 'package:poimen/services/cloudinary_service.dart';
import 'package:poimen/services/gql_query_container.dart';
import 'package:poimen/state/enums.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/avatar_with_initials.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:poimen/widgets/user_header_widget.dart';
import 'package:provider/provider.dart';

class FellowshipTrendsScreen extends StatelessWidget {
  const FellowshipTrendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var churchState = Provider.of<SharedState>(context);
    const headerStyle = TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.w500,
    );

    return GQLQueryContainer(
      query: getFellowshipTrendsMenu,
      variables: {'id': churchState.fellowshipId},
      defaultPageTitle: 'Trends Menu',
      bodyFunction: (data) {
        Widget body;

        final fellowship = ChurchForTrendsMenu.fromJson(data?['fellowships'][0]);
        final leader = fellowship.leader;
        final picture = CloudinaryImage(
          url: leader.pictureUrl,
          size: ImageSize.lg,
        );

        body = ListView(
          children: const [
            UserHeaderWidget(),
            Padding(padding: EdgeInsets.all(8.0)),
            HomePageButton(
              text: 'Pastoral Work',
              icon: FontAwesomeIcons.p,
              route: '/fellowship/pastoral-work',
              navKey: 'fellowshipPastoralWork',
              permitted: [Role.leaderFellowship],
            ),
            HomePageButton(
              text: 'Membership Attendance',
              icon: FontAwesomeIcons.m,
              route: '/fellowship/membership-attendance',
              navKey: 'fellowshipMembershipAttendance',
              permitted: [Role.leaderFellowship],
            ),
          ],
        );

        var returnValues = GQLQueryContainerReturnValue(
          pageTitle: PageTitle(church: fellowship, pageTitle: 'Trends Menu'),
          body: body,
        );

        return returnValues;
      },
    );
  }
}
