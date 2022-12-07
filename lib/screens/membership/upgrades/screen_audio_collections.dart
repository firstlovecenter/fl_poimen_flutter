import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:poimen/screens/membership/upgrades/gql_member_upgrades.dart';
import 'package:poimen/screens/membership/upgrades/widget_boolean_upgrade.dart';

class AudioCollectionsScreen extends StatefulHookWidget {
  const AudioCollectionsScreen({Key? key}) : super(key: key);

  @override
  State<AudioCollectionsScreen> createState() => _AudioCollectionsScreenState();
}

class _AudioCollectionsScreenState extends State<AudioCollectionsScreen> {
  @override
  Widget build(BuildContext context) {
    final audioCollectionsUpgradeMutation = useMutation(
      MutationOptions(
        document: recordMemberAudioCollectionsUpgrade,
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
        title: 'Audio Collections',
        upgradeRequirements: 'All Audio Collections',
        booleanMutation: audioCollectionsUpgradeMutation);
  }
}
