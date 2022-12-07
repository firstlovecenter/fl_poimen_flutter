import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:poimen/screens/membership/upgrades/gql_member_upgrades.dart';
import 'package:poimen/screens/membership/upgrades/widget_boolean_upgrade.dart';

class BibleTranslationsScreen extends StatefulHookWidget {
  const BibleTranslationsScreen({Key? key}) : super(key: key);

  @override
  State<BibleTranslationsScreen> createState() => _BibleTranslationsScreenState();
}

class _BibleTranslationsScreenState extends State<BibleTranslationsScreen> {
  @override
  Widget build(BuildContext context) {
    final bibleTranslationsUpgradeMutation = useMutation(
      MutationOptions(
        document: recordMemberBibleTranslationsUpgrade,
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
        title: 'Bible Translations',
        upgradeRequirements: 'At Least 3 Bible Translations',
        booleanMutation: bibleTranslationsUpgradeMutation);
  }
}
