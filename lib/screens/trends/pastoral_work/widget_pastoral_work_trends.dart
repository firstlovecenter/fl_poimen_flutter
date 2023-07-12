import 'package:flutter/material.dart';
import 'package:poimen/screens/trends/pastoral_work/models_pastoral_work_trends.dart';
import 'package:poimen/screens/trends/pastoral_work/utils_pastoral_work.dart';

class PastoralWorkTrendsWidget extends StatelessWidget {
  const PastoralWorkTrendsWidget({Key? key, required this.church}) : super(key: key);
  final ChurchForPastoralWorkTrends church;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ...church.pastoralCycles.map(
          (cycle) {
            return Text(
              'months ${nameCycle(DateTime.parse(cycle.startDate), DateTime.parse(cycle.endDate))}',
            );
          },
        ).toList()
      ],
    );
  }
}
