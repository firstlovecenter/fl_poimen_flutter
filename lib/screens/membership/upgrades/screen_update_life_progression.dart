import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:poimen/screens/membership/upgrades/gql_member_upgrades.dart';
import 'package:poimen/screens/membership/upgrades/models_membership_upgrades.dart';
import 'package:poimen/screens/membership/upgrades/widget_life_progression.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/alert_box.dart';
import 'package:poimen/widgets/loading_screen.dart';
import 'package:provider/provider.dart';

class UpdateLifeProgressionScreen extends StatefulHookWidget {
  const UpdateLifeProgressionScreen({Key? key}) : super(key: key);

  @override
  State<UpdateLifeProgressionScreen> createState() => _UpdateLifeProgressionScreenState();
}

class _UpdateLifeProgressionScreenState extends State<UpdateLifeProgressionScreen> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<SharedState>();

    final lifeProgressionUpgradeMutation = useMutation(
      MutationOptions(
        document: updateMemberLifeProgression,
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
                      title: 'Life Progression Upgrade',
                      message: 'Member upgraded successfully!',
                      buttonText: 'OK',
                      onRetry: () => // pop two screens from navigator
                          Navigator.of(context)
                              .popUntil(ModalRoute.withName('/member-life-progression')),
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
                  title: 'Error Submitting Life Progression Report',
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

    final lifeProgressionQuery = useQuery(QueryOptions(
      document: getMemberLifeProgression,
      variables: {
        'id': appState.memberId,
      },
    ));

    if (lifeProgressionQuery.result.hasException) {
      return Text(lifeProgressionQuery.result.exception.toString());
    }

    if (lifeProgressionQuery.result.isLoading) {
      return const LoadingScreen();
    }

    final member =
        MemberWithLifeProgression.fromJson(lifeProgressionQuery.result.data?['members'][0]);

    return LifeProgressionWidget(
      title: 'Life Progression Upgrades',
      member: member,
      lifeProgressionMutation: lifeProgressionUpgradeMutation,
    );
  }
}
