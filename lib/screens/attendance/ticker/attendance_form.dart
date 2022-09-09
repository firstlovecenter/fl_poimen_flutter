import 'package:flutter/material.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/state/enums.dart';

class AttendanceTickerScreen extends StatefulWidget {
  const AttendanceTickerScreen({Key? key, required this.church}) : super(key: key);

  final ChurchForMemberList church;

  @override
  State<AttendanceTickerScreen> createState() => _AttendanceTickerScreenState();
}

class _AttendanceTickerScreenState extends State<AttendanceTickerScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: ListView(
        children: [
          ShowMembersIfAny(
            members: widget.church.sheep,
            category: MemberCategory.Sheep,
          ),
          ShowMembersIfAny(
            members: widget.church.goats,
            category: MemberCategory.Goat,
          ),
          ShowMembersIfAny(category: MemberCategory.Deer, members: widget.church.deer),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement code to send list of member ids to mutation

              // Validate returns true if the form is valid, or false otherwise.
              if (_formKey.currentState!.validate()) {
                // If the form is valid, display a snackbar. In the real world,
                // you'd often call a server or save the information in a database.
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data')),
                );
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}

class ShowMembersIfAny extends StatelessWidget {
  const ShowMembersIfAny({Key? key, required this.category, required this.members})
      : super(key: key);

  final List<MemberForList> members;
  final MemberCategory category;

  @override
  Widget build(BuildContext context) {
    return members.isEmpty
        ? const Padding(
            padding: EdgeInsets.all(8.0),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                category.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              ...members.map((member) => Text('${member.firstName} ${member.lastName}')).toList(),
            ],
          );
  }
}
