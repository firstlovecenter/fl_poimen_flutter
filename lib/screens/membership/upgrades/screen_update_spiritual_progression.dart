import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:poimen/screens/membership/upgrades/gql_member_upgrades.dart';
import 'package:poimen/screens/membership/upgrades/models_membership_upgrades.dart';
import 'package:poimen/screens/membership/upgrades/widget_spiritual_progression.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/alert_box.dart';
import 'package:poimen/widgets/loading_screen.dart';
import 'package:provider/provider.dart';

class UpdateSpiritualProgressionScreen extends StatefulHookWidget {
  const UpdateSpiritualProgressionScreen({Key? key}) : super(key: key);

  @override
  State<UpdateSpiritualProgressionScreen> createState() => _UpdateSpiritualProgressionScreenState();
}

class _UpdateSpiritualProgressionScreenState extends State<UpdateSpiritualProgressionScreen> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<SharedState>();

    final spiritualProgressionUpgradeMutation = useMutation(
      MutationOptions(
        document: updateMemberSpiritualProgression,
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
                      title: 'Spiritual Progression Upgrade',
                      message: 'Member upgraded successfully!',
                      buttonText: 'OK',
                      onRetry: () => // pop two screens from navigator
                          Navigator.of(context)
                              .popUntil(ModalRoute.withName('/member-spiritual-progression')),
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
                  title: 'Error Submitting Spiritual Progression Report',
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

    final spiritualProgressionQuery = useQuery(QueryOptions(
      document: getMemberSpiritualProgression,
      variables: {
        'id': appState.memberId,
      },
    ));

    if (spiritualProgressionQuery.result.hasException) {
      return Text(spiritualProgressionQuery.result.exception.toString());
    }

    if (spiritualProgressionQuery.result.isLoading) {
      return const LoadingScreen();
    }

    final member = MemberWithSpiritualProgression.fromJson(
        spiritualProgressionQuery.result.data?['members'][0]);

    return SpiritualProgressionWidget(
      title: 'Spiritual Progression Upgrades',
      member: member,
      spiritualProgressionMutation: spiritualProgressionUpgradeMutation,
    );
  }
}
