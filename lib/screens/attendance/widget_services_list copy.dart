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
          Card(
            margin: const EdgeInsets.only(bottom: 15),
            child: ListTile(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/${serviceType.toLowerCase()}/attendance-ticker',
                );
              },
              title: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(service.serviceDate.humanReadable),
                  // Text(
                  //   timeago.format(service.serviceDate.date),
                  //   style: const TextStyle(color: PoimenTheme.textSecondary, fontSize: 12),
                  // ),
                ],
              ),
              // subtitle: Text(
              //   'Attendance: ${service.attendance ?? 0.toString()}',
              //   style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              // ),
              // trailing: service.markedAttendance
              //     ? const Icon(
              //         FontAwesomeIcons.solidCircleCheck,
              //         color: Colors.green,
              //       )
              //     : null,
            ),
          ),
        ],
      ),
    );
  }
}
