import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:poimen/screens/membership/upgrades/gql_member_upgrades.dart';
import 'package:poimen/screens/membership/upgrades/widget_baptism_form.dart';
import 'package:poimen/widgets/alert_box.dart';

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
                      title: 'Holy Ghost Baptism Upgrade',
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
                  title: 'Error Submitting Holy Ghost Baptism Report',
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

    return BaptismFormWidget(
        title: 'Holy Ghost Baptism', baptismMutation: holyGhostUpgradeMutation);
  }
}
