import 'package:flutter/material.dart';
import 'package:poimen/screens/attendance/report/models_service_reports.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/member_tile.dart';
import 'package:poimen/widgets/attendance_image_carousel.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChurchRehearsalsReport extends StatelessWidget {
  const ChurchRehearsalsReport({Key? key, required this.church, required this.record})
      : super(key: key);

  final Church church;
  final RehearsalsForReport record;

  @override
  Widget build(BuildContext context) {
    final int totalMembership = record.membersAbsent.length + record.membersPresent.length;

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Summary for ${record.serviceDate.humanReadable}',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              Text(
                timeago.format(record.serviceDate.date),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: PoimenTheme.brandTextPrimary,
                    fontSize: 16.0),
              ),
            ],
          ),
        ),
        const Padding(padding: EdgeInsets.all(10.0)),
        AttendanceImageCarousel(membersPicture: record.membersPicture),
        const Padding(padding: EdgeInsets.all(10.0)),
        _ShowMembers(
          status: AttendanceStatus.absent,
          members: record.membersAbsent,
          title: 'Members Who Were Absent: ${record.membersAbsent.length}/$totalMembership',
        ),
        _ShowMembers(
          status: AttendanceStatus.present,
          title: 'Members Who Were Present: ${record.membersPresent.length}/$totalMembership',
          members: record.membersPresent,
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/rehearsal-meetings', (route) => false);
            },
            child: const Text('Go to Rehearsals List'),
          ),
        ),
      ],
    );
  }
}

enum AttendanceStatus { present, absent }

class _ShowMembers extends StatelessWidget {
  const _ShowMembers({Key? key, required this.members, required this.title, required this.status})
      : super(key: key);

  final List<MemberForListWithBacenta> members;
  final String title;
  final AttendanceStatus status;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(fontSize: 18),
            ),
          ),
          ...members.map((member) {
            return memberTile(context, member, member.bacenta);
          }).toList()
        ],
      ),
    );
  }
}
