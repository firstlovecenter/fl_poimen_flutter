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
  final bool? navigateBack;

  const HomePageButton({
    Key? key,
    required this.text,
    required this.icon,
    required this.route,
    required this.navKey,
    required this.permitted,
    this.alertNumber,
    this.navigateBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userState = context.watch<SharedState>();
    if (!permitted.contains(userState.role) && !permitted.contains(Role.all)) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Card(
        elevation: 1,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: Colors.grey.shade200,
            width: 1,
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          splashColor: PoimenTheme.brand.withOpacity(0.1),
          highlightColor: PoimenTheme.brand.withOpacity(0.05),
          onTap: () {
            userState.bottomNavSelected = navKey;
            if (navigateBack != null && navigateBack == true) {
              Navigator.pushNamed(context, route);
            } else {
              Navigator.of(context).pushNamedAndRemoveUntil(route, (route) => false);
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 4.0),
            child: ListTile(
              dense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              title: Text(
                text,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: PoimenTheme.brand.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: PoimenTheme.brand,
                ),
              ),
              trailing: alertNumber != null
                  ? TrailingCardAlertNumber(
                      number: alertNumber ?? 0,
                      variant: alertNumber == 0
                          ? TrailingCardAlertNumberVariant.green
                          : TrailingCardAlertNumberVariant.red,
                    )
                  : const Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: Colors.grey,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
