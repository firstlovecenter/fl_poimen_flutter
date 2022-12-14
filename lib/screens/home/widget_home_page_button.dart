import 'package:poimen/state/enums.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/traliing_alert_number.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePageButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final String navKey;
  final String route;
  final List<Role> permitted;
  final int? alertNumber;

  const HomePageButton({
    Key? key,
    required this.text,
    required this.icon,
    required this.route,
    required this.navKey,
    required this.permitted,
    this.alertNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userState = Provider.of<SharedState>(context);
    if (!permitted.contains(userState.role) && !permitted.contains(Role.all)) {
      return Container();
    }

    return Column(
      children: [
        Card(
          child: ListTile(
            onTap: () {
              userState.bottomNavSelected = navKey;
              Navigator.of(context).pushNamedAndRemoveUntil(route, (route) => false);
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // <-- Radius
            ),
            minVerticalPadding: const EdgeInsets.only(top: 13, bottom: 13).vertical,
            title: Text(text),
            leading: CircleAvatar(
              backgroundColor: PoimenTheme.brand,
              child: Center(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.white,
                ),
              ),
            ),
            trailing: alertNumber != null
                ? TrailingCardAlertNumber(
                    number: alertNumber ?? 0,
                    variant: TrailingCardAlertNumberVariant.red,
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
