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
          Container(
            margin: const EdgeInsets.only(bottom: 20.0),
            height: 60.0,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/governorship/attendance-ticker',
                );
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.resolveWith<Color>(
                  (Set<WidgetState> states) {
                    if (states.contains(WidgetState.pressed)) {
                      return PoimenTheme.bad.withOpacity(0.8); // Darker when pressed
                    } else if (states.contains(WidgetState.hovered)) {
                      return PoimenTheme.bad.withOpacity(0.9); // Slightly darker on hover
                    } else if (states.contains(WidgetState.disabled)) {
                      return Colors.grey.shade400; // Grey when disabled
                    }
                    return PoimenTheme.bad; // Default red
                  },
                ),
                foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                elevation: WidgetStateProperty.resolveWith<double>(
                  (Set<WidgetState> states) {
                    if (states.contains(WidgetState.pressed)) {
                      return 2.0; // Lower elevation when pressed
                    } else if (states.contains(WidgetState.hovered)) {
                      return 6.0; // Higher elevation on hover
                    }
                    return 5.0; // Default elevation
                  },
                ),
                overlayColor: WidgetStateProperty.all<Color>(Colors.white.withOpacity(0.1)),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FontAwesomeIcons.plusCircle,
                    color: Colors.white,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Record Meeting',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
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
