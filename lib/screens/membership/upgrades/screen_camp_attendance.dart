import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:poimen/screens/membership/upgrades/gql_member_upgrades.dart';
import 'package:poimen/screens/membership/upgrades/widget_boolean_upgrade.dart';

class CampAttendanceScreen extends StatefulHookWidget {
  const CampAttendanceScreen({Key? key}) : super(key: key);

  @override
  State<CampAttendanceScreen> createState() => _CampAttendanceScreenState();
}

class _CampAttendanceScreenState extends State<CampAttendanceScreen> {
  @override
  Widget build(BuildContext context) {
    final campAttendanceUpgradeMutation = useMutation(
      MutationOptions(
        document: recordMemberCampAttendanceUpgrade,
        // ignore: void_checks
        update: (cache, result) {
          return cache;
        },
        onCompleted: (resultData) {
          if (resultData == null) {
            return;
          }

          Navigator.of(context).popUntil(ModalRoute.withName('/membership-upgrades'));
        },
      ),
    );

    return BooleanUpgradeWidget(
        title: 'Camp Attendance',
        upgradeRequirements: 'Attended Camp With Prophet or Other Bishops',
        booleanMutation: campAttendanceUpgradeMutation);
  }
}
