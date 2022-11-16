import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:poimen/screens/membership/details/upgrades/gql_member_upgrades.dart';
import 'package:poimen/screens/membership/details/upgrades/widget_baptism_form.dart';

class WaterBaptismScreen extends StatefulHookWidget {
  const WaterBaptismScreen({Key? key}) : super(key: key);

  @override
  State<WaterBaptismScreen> createState() => _WaterBaptismScreenState();
}

class _WaterBaptismScreenState extends State<WaterBaptismScreen> {
  @override
  Widget build(BuildContext context) {
    final waterUpgradeMutation = useMutation(
      MutationOptions(
        document: recordMemberWaterBaptismUpgrade,
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

    return BaptismFormWidget(title: 'Water Baptism', baptismMutation: waterUpgradeMutation);
  }
}
