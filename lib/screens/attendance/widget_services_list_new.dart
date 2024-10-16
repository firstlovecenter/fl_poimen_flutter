import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:poimen/screens/attendance/models_services.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/no_data.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class RecordedMeetingsList extends StatelessWidget {
  const RecordedMeetingsList({Key? key, required this.meetings}) : super(key: key);

  final List<ServicesForList> meetings;

  @override
  Widget build(BuildContext context) {
    String serviceType = '';
    var churchState = context.watch<SharedState>();

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListView(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/constituency/attendance-ticker',
              );
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Record Meeting',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          ...noDataChecker(meetings.map((meeting) {
            return Card(
              margin: const EdgeInsets.only(bottom: 15),
              child: ListTile(
                onTap: () {
                  serviceType = meeting.typename;
                  context.read<SharedState>().serviceRecordId = meeting.id;

                  if (!meeting.markedAttendance) {
                    Navigator.pushNamed(
                      context,
                      '/${serviceType.toLowerCase()}/attendance-ticker',
                    );
                  } else {
                    churchState.serviceRecordId = meeting.id;
                    Navigator.pushNamed(
                      context,
                      '/meetings/attendance-report',
                    );
                  }
                },
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(meeting.serviceDate.humanReadable),
                    Text(
                      timeago.format(meeting.serviceDate.date),
                      style: const TextStyle(color: PoimenTheme.textSecondary, fontSize: 12),
                    ),
                  ],
                ),
                subtitle: Text(
                  'Attendance: ${meeting.attendance ?? 0.toString()}',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                trailing: meeting.markedAttendance
                    ? const Icon(
                        FontAwesomeIcons.solidCircleCheck,
                        color: Colors.green,
                      )
                    : const Icon(
                        FontAwesomeIcons.circle,
                        color: PoimenTheme.textSecondary,
                      ),
              ),
            );
          }).toList()),
        ],
      ),
    );
  }
}
