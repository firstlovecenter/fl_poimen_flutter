import 'package:flutter/material.dart';
import 'package:poimen/screens/membership/gql_member_details.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/gql_container.dart';
import 'package:provider/provider.dart';

class MemberDetailsScreen extends StatelessWidget {
  const MemberDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<SharedState>(context);

    return GQLContainer(
      query: getMemberDetails,
      variables: {'id': state.memberId},
      defaultPageTitle: 'Member Details',
      bodyFunction: (data) {
        final member = Member.fromJson(data?['members'][0]);

        var returnValues = GQLContainerReturnValue(
          pageTitle: 'Member Details',
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(child: Text('${member.firstName} ${member.lastName}')),
              const BioDetailsCard(title: 'Sex', detail: 'Female'),
              const BioDetailsCard(title: 'Date of Birth', detail: 'DOB'),
              BioDetailsCard(title: 'Phone Number', detail: '+${member.phoneNumber}'),
              BioDetailsCard(title: 'Whatsapp Number', detail: '+${member.whatsappNumber}'),
              BioDetailsCard(title: 'Stream', detail: member.stream_name as String),
              BioDetailsCard(title: 'Fellowship', detail: member.fellowship.name),
              BioDetailsCard(title: 'Basonta', detail: member.ministry?.name ?? ''),
              const BioDetailsCard(title: 'Holy Ghost Baptism', detail: 'detail'),
              const BioDetailsCard(title: 'Water Baptism', detail: 'detail'),
              const BioDetailsCard(title: 'Notes', detail: '...'),
              const BioDetailsCard(title: 'Invited By', detail: '...'),
              const BioDetailsCard(title: 'Last Visited', detail: '...'),
            ],
          ),
        );

        return returnValues;
      },
    );
  }
}

class BioDetailsCard extends StatelessWidget {
  const BioDetailsCard({
    Key? key,
    required this.title,
    required this.detail,
  }) : super(key: key);

  final String title;
  final String detail;

  @override
  Widget build(BuildContext context) {
    const titleStyle = TextStyle(color: Color(0xffffffff), fontSize: 15);

    const detailStyle =
        TextStyle(color: Color(0x88ffffff), fontSize: 15, fontWeight: FontWeight.bold);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 12, left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: titleStyle,
            ),
            Text(
              detail,
              style: detailStyle,
            )
          ],
        ),
      ),
    );
  }
}
