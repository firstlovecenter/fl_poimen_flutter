import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:poimen/screens/home/models_home_screen.dart';
import 'package:poimen/screens/home/utils_home.dart';
import 'package:poimen/screens/home/widget_home_page_button.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/services/auth_service.dart';
import 'package:poimen/services/cloudinary_service.dart';
import 'package:poimen/state/enums.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/avatar_with_initials.dart';
import 'package:provider/provider.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({
    Key? key,
    required this.church,
  }) : super(key: key);

  final HomeScreenChurch church;

  @override
  Widget build(BuildContext context) {
    var churchState = Provider.of<SharedState>(context);
    String level = church.typename.toLowerCase();
    final churchLevel = convertToChurchEnum(level);
    final levelForUrl = churchLevel.name.toLowerCase();

    Future.delayed(Duration.zero, () {
      if (church.currentPastoralCycle != null) {
        churchState.pastoralCycle = church.currentPastoralCycle!;
      }
    });

    var role = parseRole(churchState.role);
    final authUser = AuthService.instance.idToken;

    final user = MemberForList(
      id: authUser!.sub,
      typename: 'Member',
      status: 'Sheep',
      firstName: authUser.given_name,
      lastName: authUser.family_name,
      pictureUrl: authUser.picture,
      phoneNumber: '0000',
      whatsappNumber: '0000',
    );
    final picture = CloudinaryImage(url: authUser.picture, size: ImageSize.lg);

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    authUser.name,
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    role,
                    style: const TextStyle(color: PoimenTheme.textSecondary),
                  )
                ],
              ),
              const Padding(padding: EdgeInsets.all(10.0)),
              Column(
                children: [
                  AvatarWithInitials(
                    foregroundImage: picture.image,
                    member: user,
                    radius: 45,
                  ),
                ],
              )
            ],
          ),
          ...countdownLevels(church),
          const Padding(padding: EdgeInsets.all(20.0)),
          Text(
            '${church.name} ${church.typename}',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 22),
          ),
          const Padding(padding: EdgeInsets.all(5.0)),
          ...attendanceLevels(churchLevel),
          HomePageButton(
            text: 'First Timers and New Converts',
            icon: FontAwesomeIcons.userPlus,
            navKey: 'idls',
            route: '/$levelForUrl-idls',
            permitted: const [Role.leaderFellowship],
          ),
          HomePageButton(
            text: 'Membership List',
            navKey: 'membership',
            icon: FontAwesomeIcons.solidAddressBook,
            route: '/$levelForUrl-members',
            permitted: const [Role.all],
          ),
          defaultersLevels(churchLevel, church.fellowshipAttendanceDefaultersCount),
          const Padding(padding: EdgeInsets.all(6.0)),
          const Center(
            child: Text(
              'Outstanding Work',
              style: TextStyle(
                fontSize: 18,
                color: PoimenTheme.textSecondary,
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.all(6.0)),
          HomePageButton(
            text: 'Missing Persons Call List',
            icon: FontAwesomeIcons.personCircleQuestion,
            navKey: 'imcls',
            route: '/$levelForUrl-imcls',
            alertNumber: church.imclTotal,
            permitted: const [Role.leaderFellowship, Role.leaderBacenta],
          ),
          imclLevels(churchLevel, church.imclTotal),
          outstandingVisitationLevels(churchLevel, church.outstandingVisitationsCount),
          outstandingPrayerLevels(churchLevel, church.outstandingPrayerCount),
          outstandingTelepastoringLevels(churchLevel, church.outstandingTelepastoringCount)
        ],
      ),
    );
  }
}
