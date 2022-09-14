import 'package:flutter/material.dart';
import 'package:poimen/screens/attendance/report/models_service_reports.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/avatar_with_initials.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChurchServicesReport extends StatelessWidget {
  const ChurchServicesReport({Key? key, required this.church, required this.record})
      : super(key: key);

  final Church church;
  final ServicesForReport record;

  @override
  Widget build(BuildContext context) {
    return Column(
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
        _ShowMembers(membersPresent: record.membersPresent)
      ],
    );
  }
}

class _ShowMembers extends StatelessWidget {
  const _ShowMembers({Key? key, required this.membersPresent}) : super(key: key);

  final List<MemberForList> membersPresent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: membersPresent.map((member) {
        return ListTile(
          leading: AvatarWithInitials(
            member: member,
            foregroundImage: NetworkImage(member.pictureUrl),
          ),
          title: Text('${member.firstName} ${member.lastName}'),
          subtitle: Text(member.status?.name ?? ''),
        );
      }).toList(),
    );
  }
}
