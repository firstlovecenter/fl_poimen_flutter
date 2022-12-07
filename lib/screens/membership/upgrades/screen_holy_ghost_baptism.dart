import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:poimen/screens/membership/upgrades/gql_member_upgrades.dart';
import 'package:poimen/screens/membership/upgrades/widget_baptism_form.dart';

class HolyGhostBaptismScreen extends StatefulHookWidget {
  const HolyGhostBaptismScreen({Key? key}) : super(key: key);

  @override
  State<HolyGhostBaptismScreen> createState() => _HolyGhostBaptismScreenState();
}

class _HolyGhostBaptismScreenState extends State<HolyGhostBaptismScreen> {
  @override
  Widget build(BuildContext context) {
    final holyGhostUpgradeMutation = useMutation(
      MutationOptions(
        document: recordMemberHolyGhostBaptismUpgrade,
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

    return BaptismFormWidget(
        title: 'Holy Ghost Baptism', baptismMutation: holyGhostUpgradeMutation);
  }
}
