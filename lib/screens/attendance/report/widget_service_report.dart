import 'package:flutter/material.dart';
import 'package:poimen/screens/attendance/report/models_service_reports.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/member_tile.dart';
import 'package:poimen/widgets/attendance_image_carousel.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChurchServicesReport extends StatelessWidget {
  const ChurchServicesReport({Key? key, required this.church, required this.record})
      : super(key: key);

  final Church church;
  final ServicesForReport record;

  @override
  Widget build(BuildContext context) {
    final int totalMembership =
        record.membersAbsentFromFellowship.length + record.membersPresentFromFellowship.length;

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
        const Padding(padding: EdgeInsets.all(8.0)),
        _ShowMembers(
          members: record.membersAbsentFromFellowship,
          title:
              'Members Who Were Absent: ${record.membersAbsentFromFellowship.length}/$totalMembership',
        ),
        const Padding(padding: EdgeInsets.all(15.0)),
        _ShowMembers(
          title:
              'Members Who Were Present: ${record.membersPresentFromFellowship.length}/$totalMembership',
          members: record.membersPresentFromFellowship,
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/${record.typename.toLowerCase()}-services', (route) => false);
            },
            child: const Text('Go to Services List'),
          ),
        ),
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
