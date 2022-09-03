import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            HomePageButton(
              text: 'Bacenta Attendance',
              icon: FontAwesomeIcons.clipboardUser,
              route: '/fellowship-members',
              permitted: ['leaderBacenta'],
            ),
            Padding(padding: EdgeInsets.all(8)),
            HomePageButton(
              text: 'Fellowship Attendance',
              icon: FontAwesomeIcons.clipboardUser,
              route: '/fellowship-members',
              permitted: ['leaderFellowship'],
            ),
            Padding(padding: EdgeInsets.all(8)),
            HomePageButton(
              text: 'First Timers and New Converts',
              icon: FontAwesomeIcons.clipboardUser,
              route: '/fellowship-members',
              permitted: ['all'],
            ),
            Padding(padding: EdgeInsets.all(8)),
            HomePageButton(
              text: 'Membership List',
              icon: FontAwesomeIcons.clipboardUser,
              route: '/fellowship-members',
              permitted: ['all'],
            ),
          ],
        ),
      ),
    );
  }
}

class HomePageButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final String route;
  final List<String> permitted;

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
    if (!permitted.contains(userState.role) && !permitted.contains('all')) {
      return Container();
    }

    return InkWell(
      onTap: () {},
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.pushNamed(context, route);
        },
        icon: CircleAvatar(
          backgroundColor: Colors.red,
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
          padding: const EdgeInsets.only(top: 13, bottom: 13, left: 20),
          primary: Colors.black87,
          textStyle: const TextStyle(fontSize: 18),
        ),
        label: Text(
          text,
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}
