import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:poimen/screens/trends/pastoral_work/models_pastoral_work_trends.dart';
import 'package:poimen/screens/trends/pastoral_work/utils_pastoral_work.dart';

class PastoralWorkTrendsWidget extends StatelessWidget {
  const PastoralWorkTrendsWidget({Key? key, required this.church}) : super(key: key);
  final ChurchForPastoralWorkTrendsWithCounts church;

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color kPrimaryColor =
        isDark ? const Color.fromARGB(255, 251, 192, 192) : const Color.fromARGB(255, 104, 28, 22);

    return ListView(
      children: [
        ...church.pastoralCycles.map(
          (cycle) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      nameCycle(DateTime.parse(cycle.startDate), DateTime.parse(cycle.endDate)),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                      ),
                    ),
                    PastoralWorkCycleTile(
                      church: church,
                      cycle: cycle,
                      duty: Duty(
                          name: 'Visitation',
                          number: cycle.visitationsByChurchCount,
                          icon: FontAwesomeIcons.doorOpen),
                    ),
                    PastoralWorkCycleTile(
                      church: church,
                      cycle: cycle,
                      duty: Duty(
                          name: 'Prayer',
                          number: cycle.prayersByChurchCount,
                          icon: FontAwesomeIcons.personPraying),
                    ),
                    PastoralWorkCycleTile(
                      church: church,
                      cycle: cycle,
                      duty: Duty(
                          name: 'Telepastoring',
                          number: cycle.telepastoringsByChurchCount,
                          icon: FontAwesomeIcons.phone),
                    ),
                  ],
                ),
              ),
            );
          },
        ).toList()
      ],
    );
  }
}

class Duty {
  final String name;
  final int number;
  final IconData icon;

  Duty({required this.name, required this.number, required this.icon});
}

class PastoralWorkCycleTile extends StatelessWidget {
  const PastoralWorkCycleTile({
    super.key,
    required this.church,
    required this.cycle,
    required this.duty,
  });

  final ChurchForPastoralWorkTrendsWithCounts church;
  final PastoralCycleCountsForTrends cycle;
  final Duty duty;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(duty.icon),
      title: Text('${duty.number} ${duty.number > 1 ? '${duty.name}s' : duty.name}'),
      trailing: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/${church.typename.toLowerCase()}/pastoral_work/cycles/${duty.name.toLowerCase()}',
            arguments: cycle,
          );
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: const Text('Details'),
      ),
    );
  }
}
