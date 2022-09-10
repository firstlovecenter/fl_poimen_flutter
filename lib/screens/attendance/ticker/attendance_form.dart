import 'package:flutter/material.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/services/cloudinary_service.dart';
import 'package:poimen/state/enums.dart';
import 'package:poimen/widgets/avatar_with_initials.dart';

class AttendanceTickerScreen extends StatefulWidget {
  const AttendanceTickerScreen({Key? key, required this.church}) : super(key: key);

  final ChurchForMemberList church;

  @override
  State<AttendanceTickerScreen> createState() => _AttendanceTickerScreenState();
}

class _AttendanceTickerScreenState extends State<AttendanceTickerScreen> {
  final List<String> _selectedMembers = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              ShowMembersIfAny(
                members: widget.church.sheep,
                category: MemberCategory.Sheep,
                selectedMembers: _selectedMembers,
              ),
              ShowMembersIfAny(
                members: widget.church.goats,
                category: MemberCategory.Goat,
                selectedMembers: _selectedMembers,
              ),
              ShowMembersIfAny(
                category: MemberCategory.Deer,
                members: widget.church.deer,
                selectedMembers: _selectedMembers,
              ),
            ],
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(80),
          ),
          onPressed: () {
            // TODO: Implement code to send list of member ids to mutation
            print(_selectedMembers);
            // Validate returns true if the form is valid, or false otherwise.
            if (_selectedMembers.isNotEmpty) {
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
    );
  }
}

class ShowMembersIfAny extends StatefulWidget {
  const ShowMembersIfAny(
      {Key? key, required this.category, required this.members, required this.selectedMembers})
      : super(key: key);

  final List<MemberForList> members;
  final MemberCategory category;
  final List<String> selectedMembers;

  @override
  State<ShowMembersIfAny> createState() => _ShowMembersIfAnyState();
}

class _ShowMembersIfAnyState extends State<ShowMembersIfAny> {
  @override
  Widget build(BuildContext context) {
    return widget.members.isEmpty
        ? const Padding(
            padding: EdgeInsets.all(8.0),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  widget.category.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
              ...widget.members
                  .map((member) => Column(
                        children: [
                          CheckboxListTile(
                            activeColor: Colors.deepPurpleAccent,
                            checkColor: Colors.black54,
                            value: widget.selectedMembers.contains(member.id),
                            onChanged: (bool? value) {
                              setState(() {
                                if (value!) {
                                  widget.selectedMembers.add(member.id);
                                } else {
                                  widget.selectedMembers.remove(member.id);
                                }

                                print(widget.selectedMembers);
                              });
                            },
                            secondary: AvatarWithInitials(
                              member: member,
                              foregroundImage: CloudinaryImage(url: member.pictureUrl).image,
                            ),
                            title: Text('${member.firstName} ${member.lastName}'),
                          ),
                          const Divider(
                            color: Colors.white,
                            height: 0.0,
                          )
                        ],
                      ))
                  .toList(),
            ],
          );
  }
}
