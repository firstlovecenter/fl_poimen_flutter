import 'package:flutter/material.dart';
import 'package:poimen/screens/attendance/report/models_service_reports.dart';
import 'package:poimen/screens/membership/idl/widget_idl_list.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/theme.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChurchServicesReport extends StatelessWidget {
  const ChurchServicesReport({Key? key, required this.church, required this.record})
      : super(key: key);

  final Church church;
  final ServicesForReport record;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Padding(padding: EdgeInsets.all(8.0)),
        Text(
          'Summary for ${record.serviceDate.humanReadable}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          timeago.format(record.serviceDate.date),
          style: TextStyle(fontWeight: FontWeight.bold, color: PoimenTheme.brand),
        ),
        const Padding(padding: EdgeInsets.all(8.0)),
        _ShowMembers(members: record.membersAbsent, title: 'Members Who Were Absent'),
        const Padding(padding: EdgeInsets.all(15.0)),
        _ShowMembers(title: 'Members Who Were Present', members: record.membersPresent),
      ],
    );
  }
}

class _ShowMembers extends StatelessWidget {
  const _ShowMembers({Key? key, required this.members, required this.title}) : super(key: key);

  final List<MemberForList> members;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18),
        ),
        ...members.map((member) {
          return memberTile(context, member);
        }).toList()
      ],
    );
  }
}
