import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:poimen/screens/membership/upgrades/gql_member_upgrades.dart';
import 'package:poimen/screens/membership/upgrades/widget_boolean_upgrade.dart';
import 'package:poimen/widgets/alert_box.dart';

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

          if (resultData.isNotEmpty) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    constraints: const BoxConstraints(maxHeight: 350),
                    child: AlertBox(
                      type: AlertType.success,
                      title: 'Bible Translations Upgrade',
                      message: 'Member upgraded successfully!',
                      buttonText: 'OK',
                      onRetry: () => // pop two screens from navigator
                          Navigator.of(context)
                              .popUntil(ModalRoute.withName('/membership-upgrades')),
                    ),
                  ),
                );
              },
            );
          }
        },
        onError: (error) => showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                constraints: const BoxConstraints(maxHeight: 350),
                child: AlertBox(
                  type: AlertType.error,
                  title: 'Error Submitting Bible Translations Report',
                  message: getGQLException(error),
                  buttonText: 'OK',
                  onRetry: () => Navigator.of(context).pop(),
                ),
              ),
            );
          },
        ),
      ),
    );

    return BooleanUpgradeWidget(
        title: 'Bible Translations',
        upgradeRequirements: 'At Least 3 Bible Translations',
        booleanMutation: bibleTranslationsUpgradeMutation);
  }
}
