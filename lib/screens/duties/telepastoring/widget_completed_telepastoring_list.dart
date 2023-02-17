import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:poimen/screens/duties/telepastoring/models_telepastoring.dart';
import 'package:poimen/widgets/member_tile.dart';
import 'package:poimen/widgets/no_data.dart';
import 'package:poimen/widgets/traliing_alert_number.dart';

class ChurchCompletedTelepastoringList extends StatelessWidget {
  const ChurchCompletedTelepastoringList({Key? key, required this.church}) : super(key: key);

  final ChurchForCompletedTelepastoringList church;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(children: [
        const Padding(padding: EdgeInsets.all(10)),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/${church.typename.toLowerCase()}/outstanding-telepastoring',
                    );
                  },
                  leading: const Icon(FontAwesomeIcons.phone),
                  trailing: TrailingCardAlertNumber(
                      number: church.outstandingTelepastoringCount,
                      variant: TrailingCardAlertNumberVariant.red),
                  title: const Text('Calls Remaining'),
                ),
              ],
            ),
          ),
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(
                    FontAwesomeIcons.solidThumbsUp,
                    color: Colors.green,
                  ),
                  trailing: TrailingCardAlertNumber(
                    number: church.completedTelepastoring.length,
                    variant: TrailingCardAlertNumberVariant.green,
                  ),
                  title: const Text('Calls Completed'),
                ),
              ],
            ),
          ),
        ),
        const Padding(padding: EdgeInsets.all(8.0)),
        ...noDataChecker(church.completedTelepastoring.map((member) {
          return memberTile(context, member);
        }).toList()),
      ]),
    );
  }
}
