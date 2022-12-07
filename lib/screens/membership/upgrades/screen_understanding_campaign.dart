import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:poimen/screens/membership/upgrades/gql_member_upgrades.dart';
import 'package:poimen/screens/membership/upgrades/widget_understanding_campaign.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/loading_screen.dart';
import 'package:provider/provider.dart';

class UnderstandingCampaignScreen extends StatefulHookWidget {
  const UnderstandingCampaignScreen({Key? key}) : super(key: key);

  @override
  State<UnderstandingCampaignScreen> createState() => _UnderstandingCampaignScreenState();
}

class _UnderstandingCampaignScreenState extends State<UnderstandingCampaignScreen> {
  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<SharedState>(context);

    final understandingCampaignUpgradeMutation = useMutation(
      MutationOptions(
        document: recordMemberUnderstandingCampaignUpgrade,
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

    final understandingCampaignQuery =
        useQuery(QueryOptions(document: memberUnderstandingCampaings, variables: {
      'memberId': appState.memberId,
    }));

    if (understandingCampaignQuery.result.hasException) {
      return Text(understandingCampaignQuery.result.exception.toString());
    }

    if (understandingCampaignQuery.result.isLoading) {
      return const LoadingScreen();
    }

    var understandingSchoolObject =
        understandingCampaignQuery.result.data?['members'][0]['graduatedUnderstandingSchools'];

    List<String> graduatedSchools = [...understandingSchoolObject.map((sch) => sch.toString())];

    return UnderstandingCampaignWidget(
      title: 'Understanding Campaign Upgrades',
      graduatedSchools: graduatedSchools,
      understandingCampaignMutation: understandingCampaignUpgradeMutation,
    );
  }
}
