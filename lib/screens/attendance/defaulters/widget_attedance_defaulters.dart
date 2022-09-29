import 'package:flutter/material.dart';
import 'package:poimen/screens/attendance/defaulters/models_defaulters.dart';

class ChurchAttendanceDefaulters extends StatelessWidget {
  const ChurchAttendanceDefaulters({Key? key, required this.church}) : super(key: key);

  final ChurchForAttendanceDefaulters church;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          const Padding(padding: EdgeInsets.all(80)),
          DefaultersMenuCard(
            number: church.bacentaAttendanceDefaultersCount,
            title: 'Did Not Fill Bacenta Attendance',
          ),
          const Padding(padding: EdgeInsets.all(10)),
          DefaultersMenuCard(
            number: church.fellowshipAttendanceDefaultersCount,
            title: 'Did Not Fill Fellowship Attendance',
          ),
        ],
      ),
    );
  }
}

class DefaultersMenuCard extends StatelessWidget {
  const DefaultersMenuCard({
    Key? key,
    required this.number,
    required this.title,
  }) : super(key: key);

  final int number;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 12),
        child: ListTile(
          title: Text(title),
          trailing: Card(
            color: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
              child: Text(
                '$number',
                style: const TextStyle(color: Colors.red, fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}