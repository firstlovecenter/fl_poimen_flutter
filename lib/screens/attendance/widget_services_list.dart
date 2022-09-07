import 'package:flutter/material.dart';
import 'package:poimen/screens/attendance/models_services.dart';
import 'package:poimen/widgets/no_data.dart';

class ChurchServicesList extends StatelessWidget {
  const ChurchServicesList({Key? key, required this.church}) : super(key: key);

  final ChurchForServicesList church;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(
        children: noDataChecker(church.services.map((service) {
          return Text(service.attendance.toString());
        }).toList()),
      ),
    );
  }
}
