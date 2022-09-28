import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

    var church = churchState.church;
    var role = _parseRole(churchState.role);
    final authUser = AuthService.instance.idToken;

    final user = MemberForList(
      id: authUser!.sub,
      typename: 'Member',
      firstName: authUser.given_name,
      lastName: authUser.family_name,
      pictureUrl: authUser.picture,
      whatsappNumber: '0000',
    );
    final picture = CloudinaryImage(url: authUser.picture, size: ImageSize.lg);

    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
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
            const Padding(padding: EdgeInsets.all(3)),
            HomePageButton(
              text: 'First Timers and New Converts',
              icon: FontAwesomeIcons.clipboardUser,
              route: '/${level.toLowerCase()}-idls',
              permitted: const [Role.leaderFellowship],
            ),
            const Padding(padding: EdgeInsets.all(3)),
            HomePageButton(
              text: 'Membership List',
              icon: FontAwesomeIcons.clipboardUser,
              route: '/${level.toLowerCase()}-members',
              permitted: const [Role.all],
            ),
            const Padding(padding: EdgeInsets.all(3)),
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
    icon: FontAwesomeIcons.clipboardUser,
    route: '/${level.lowerCase}-services',
    permitted: [Role.values.byName('leader${level.properCase}')],
  );
}

Widget defaultersLevels(ChurchLevel churchLevel) {
  const permittedLevels = [ChurchLevel.constituency, ChurchLevel.council, ChurchLevel.stream];

  if (!permittedLevels.contains(churchLevel)) {
    return Container();
  }

  ChurchString level = ChurchString(churchLevel.name);

  return HomePageButton(
    text: 'Attendance Defaulters',
    icon: FontAwesomeIcons.xmark,
    route: '/${level.lowerCase}/attendance-defaulters',
    permitted: [Role.values.byName('leader${level.properCase}')],
  );
}

class HomePageButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final String route;
  final List<Role> permitted;

  const HomePageButton(
      {Key? key,
      required this.text,
      required this.icon,
      required this.route,
      required this.permitted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userState = Provider.of<SharedState>(context);
    if (!permitted.contains(userState.role) && !permitted.contains(Role.all)) {
      return Container();
    }

    return ElevatedButton.icon(
      onPressed: () {
        Navigator.pushNamed(context, route);
      },
      icon: CircleAvatar(
        backgroundColor: Colors.deepPurpleAccent,
        child: Center(
          child: Icon(
            icon,
            size: 20,
            color: Colors.white,
          ),
        ),
      ),
      style: ElevatedButton.styleFrom(
        alignment: Alignment.centerLeft,
        backgroundColor: const Color(0xFF2E2E2E),
        padding: const EdgeInsets.only(top: 13, bottom: 13, left: 20),
        textStyle: const TextStyle(fontSize: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // <-- Radius
        ),
      ),
      label: Text(
        text,
        textAlign: TextAlign.left,
      ),
    );
  }
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
