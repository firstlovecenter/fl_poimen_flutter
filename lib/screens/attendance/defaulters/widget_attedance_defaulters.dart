import 'package:flutter/material.dart';
import 'package:poimen/helpers/global_functions.dart';
import 'package:poimen/screens/attendance/defaulters/models_defaulters.dart';
import 'package:poimen/state/enums.dart';
import 'package:poimen/theme.dart';

class ChurchAttendanceDefaulters extends StatelessWidget {
  const ChurchAttendanceDefaulters({Key? key, required this.church}) : super(key: key);

  final ChurchForAttendanceDefaulters church;

  @override
  Widget build(BuildContext context) {
    String level = church.typename.toLowerCase();
    final churchLevel = convertToChurchEnum(level);
    ChurchLevel subChurchLevel = getSubChurch(churchLevel);
    ChurchString subChurchString = ChurchString(subChurchLevel.name.toLowerCase());
    int? subChurchCount;

    if (church.fellowshipCount != null) {
      subChurchCount = church.fellowshipCount;
    }
    if (church.bacentaCount != null) {
      subChurchCount = church.bacentaCount;
    }

    if (church.governorshipCount != null) {
      subChurchCount = church.governorshipCount;
    }

    if (church.councilCount != null) {
      subChurchCount = church.councilCount;
    }

    if (church.streamCount != null) {
      subChurchCount = church.streamCount;
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          const Padding(padding: EdgeInsets.all(20)),
          const Text(
            'This Week',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Padding(padding: EdgeInsets.all(10)),
          InkWell(
            onTap: () => Navigator.of(context)
                .pushNamed('/${churchLevel.name}-by-${subChurchLevel.name}/attendance-defaulters'),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 12),
                child: ListTile(
                  title: Center(child: Text(subChurchString.pluralProperCase)),
                  subtitle: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '$subChurchCount',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 40, color: PoimenTheme.bad),
                    ),
                  )),
                ),
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.all(5)),
          const Divider(
            color: PoimenTheme.textSecondary,
          ),
          const Padding(padding: EdgeInsets.all(5)),
          DefaultersMenuCard(
            number: church.fellowshipBussingAttendanceDefaultersCount,
            churchLevel: church.typename.toLowerCase(),
            attendanceCategory: 'bussing',
            title: 'Did Not Fill Bussing Attendance',
          ),
          const Padding(padding: EdgeInsets.all(10)),
          DefaultersMenuCard(
            number: church.fellowshipServiceAttendanceDefaultersCount,
            churchLevel: church.typename.toLowerCase(),
            attendanceCategory: 'service',
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
    required this.churchLevel,
    required this.attendanceCategory,
  }) : super(key: key);

  final int number;
  final String title;
  final String churchLevel;
  final String attendanceCategory;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(
        '/$churchLevel/$attendanceCategory-attendance-defaulters',
      ),
      child: Card(
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
      ),
    );
  }
}
