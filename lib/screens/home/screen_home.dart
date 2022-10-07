import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:poimen/screens/home/widget_home_page_button.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/services/auth_service.dart';
import 'package:poimen/services/cloudinary_service.dart';
import 'package:poimen/state/enums.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/avatar_with_initials.dart';

import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = Provider.of<SharedState>(context);
    String level = churchState.church.typename.toLowerCase();
    final churchLevel = convertToChurchEnum(level);
    final levelForUrl = churchLevel.name.toLowerCase();

    var church = churchState.church;
    var role = _parseRole(churchState.role);
    final authUser = AuthService.instance.idToken;

    final user = MemberForList(
      id: authUser!.sub,
      typename: 'Member',
      status: 'Sheep',
      firstName: authUser.given_name,
      lastName: authUser.family_name,
      pictureUrl: authUser.picture,
      whatsappNumber: '0000',
    );
    final picture = CloudinaryImage(url: authUser.picture, size: ImageSize.lg);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        // automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
            const Padding(padding: EdgeInsets.all(10.0)),
            Text(
              '${church.name} ${church.typename}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 22),
            ),
            const Padding(padding: EdgeInsets.all(20.0)),
            attendanceLevels(churchLevel),
            HomePageButton(
              text: 'Missing Persons Call List',
              icon: FontAwesomeIcons.personCircleQuestion,
              navKey: 'idls',
              route: '/$levelForUrl-imcls',
              permitted: const [Role.leaderFellowship, Role.leaderBacenta],
            ),
            imclLevels(churchLevel, church.imclTotal),
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
            defaultersLevels(churchLevel),
          ],
        ),
      ),
    );
  }
}

Widget attendanceLevels(ChurchLevel churchLevel) {
  if (churchLevel != ChurchLevel.fellowship && churchLevel != ChurchLevel.bacenta) {
    return Container();
  }

  ChurchString level = ChurchString(churchLevel.name);

  return HomePageButton(
    text: '${level.properCase} Attendance',
    icon: FontAwesomeIcons.userCheck,
    navKey: 'attendance',
    route: '/${level.lowerCase}-services',
    permitted: [Role.values.byName('leader${level.properCase}')],
  );
}

Widget imclLevels(ChurchLevel churchLevel, int? imclTotal) {
  const permittedLevels = [
    ChurchLevel.constituency,
    ChurchLevel.council,
    ChurchLevel.stream,
    ChurchLevel.gathering
  ];

  if (!permittedLevels.contains(churchLevel) || imclTotal == 0) {
    return Container();
  }

  ChurchString level = ChurchString(churchLevel.name);

  return HomePageButton(
    text: 'IMCL Total',
    icon: FontAwesomeIcons.personCircleQuestion,
    navKey: 'imcl-total',
    route: '#',
    alertNumber: imclTotal,
    permitted: [Role.values.byName('leader${level.properCase}')],
  );
}

Widget defaultersLevels(ChurchLevel churchLevel) {
  const permittedLevels = [
    ChurchLevel.constituency,
    ChurchLevel.council,
    ChurchLevel.stream,
    ChurchLevel.gathering
  ];

  if (!permittedLevels.contains(churchLevel)) {
    return Container();
  }

  ChurchString level = ChurchString(churchLevel.name);

  return HomePageButton(
    text: 'Attendance Defaulters',
    icon: FontAwesomeIcons.userXmark,
    navKey: 'attendance-defaulters',
    route: '/${level.lowerCase}/attendance-defaulters',
    permitted: [Role.values.byName('leader${level.properCase}')],
  );
}

String _parseRole(Role role) {
  switch (role) {
    case Role.leaderFellowship:
      return 'Fellowship Leader';
    case Role.leaderBacenta:
      return 'Bacenta Leader';
    case Role.leaderConstituency:
      return 'Constituency Leader';
    case Role.leaderCouncil:
      return 'Council Leader';
    case Role.leaderStream:
      return 'Stream Leader';
    case Role.leaderGathering:
      return 'Gathering Service Leader';
    default:
      return '';
  }
}
