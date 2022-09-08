import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:poimen/screens/attendance/models_services.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/no_data.dart';
import 'package:provider/provider.dart';

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
          var newFormat = DateFormat("yMMMEd");
          String date = newFormat.format(DateTime.parse(service.serviceDate.date));

          return Card(
            margin: const EdgeInsets.only(bottom: 15),
            child: ListTile(
              onTap: () => Navigator.pushNamed(
                  context, '/${churchState.church.typename.toLowerCase()}/attendance-ticker'),
              title: Text(date),
              subtitle: Text(
                'Attendance: ${service.attendance.toString()}',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          );
        }).toList()),
      ),
    );
  }
}
