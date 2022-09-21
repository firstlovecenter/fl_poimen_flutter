import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:poimen/screens/attendance/models_services.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/no_data.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChurchServicesList extends StatelessWidget {
  const ChurchServicesList({Key? key, required this.services}) : super(key: key);

  final List<ServicesForList> services;

  @override
  Widget build(BuildContext context) {
    var churchState = Provider.of<SharedState>(context);

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView(
        children: noDataChecker(services.map((service) {
          return Card(
            margin: const EdgeInsets.only(bottom: 15),
            child: ListTile(
              onTap: () {
                if (churchState.church.typename == 'Bacenta') {
                  churchState.bussingRecordId = service.id;
                } else {
                  churchState.serviceRecordId = service.id;
                }

                if (!service.markedAttendance) {
                  Navigator.pushNamed(
                    context,
                    '/${churchState.church.typename.toLowerCase()}/attendance-ticker',
                  );
                } else {
                  Navigator.pushNamed(
                    context,
                    '/${churchState.church.typename.toLowerCase()}/attendance-report',
                  );
                }
              },
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(service.serviceDate.humanReadable),
                  Text(
                    timeago.format(service.serviceDate.date),
                    style: const TextStyle(color: PoimenTheme.textSecondary, fontSize: 12),
                  ),
                ],
              ),
              subtitle: Text(
                'Attendance: ${service.attendance.toString()}',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              trailing: service.markedAttendance ? const Icon(FontAwesomeIcons.circleCheck) : null,
            ),
          );
        }).toList()),
      ),
    );
  }
}
