import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/services/cloudinary_service.dart';
import 'package:poimen/state/enums.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/avatar_with_initials.dart';
import 'package:provider/provider.dart';

class AttendanceTickerScreen extends StatefulWidget {
  const AttendanceTickerScreen({Key? key, required this.church, required this.tickerMutation})
      : super(key: key);

  final ChurchForMemberList church;
  final MutationHookResult tickerMutation;

  @override
  State<AttendanceTickerScreen> createState() => _AttendanceTickerScreenState();
}

class _AttendanceTickerScreenState extends State<AttendanceTickerScreen> {
  final List<String> _presentMembers = [];

  @override
  Widget build(BuildContext context) {
    var churchState = Provider.of<SharedState>(context);
    List<String> absentMembers = [
      ...widget.church.sheep.map((sheep) => sheep.id),
      ...widget.church.goats.map((goat) => goat.id),
      ...widget.church.deer.map((deer) => deer.id),
    ];
    String recordId = churchState.serviceRecordId;

    if (churchState.church.typename == 'Bacenta') {
      recordId = churchState.bussingRecordId;
    }

    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              _ShowMembersIfAny(
                members: widget.church.sheep,
                category: MemberCategory.Sheep,
                presentMembers: _presentMembers,
                absentMembers: absentMembers,
              ),
              _ShowMembersIfAny(
                members: widget.church.goats,
                category: MemberCategory.Goat,
                presentMembers: _presentMembers,
                absentMembers: absentMembers,
              ),
              _ShowMembersIfAny(
                category: MemberCategory.Deer,
                members: widget.church.deer,
                presentMembers: _presentMembers,
                absentMembers: absentMembers,
              ),
            ],
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(80),
          ),
          onPressed: () {
            widget.tickerMutation.runMutation({
              'presentMembers': _presentMembers,
              'absentMembers': absentMembers,
              'recordId': recordId,
              'membersPicture':
                  'https://res.cloudinary.com/firstlovecenter/image/upload/v1627893621/user_qvwhs7.png',
            });

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Processing Data')),
            );
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}

class _ShowMembersIfAny extends StatefulWidget {
  const _ShowMembersIfAny(
      {Key? key,
      required this.category,
      required this.members,
      required this.presentMembers,
      required this.absentMembers})
      : super(key: key);

  final List<MemberForList> members;
  final MemberCategory category;
  final List<String> presentMembers;
  final List<String> absentMembers;

  @override
  State<_ShowMembersIfAny> createState() => _ShowMembersIfAnyState();
}

class _ShowMembersIfAnyState extends State<_ShowMembersIfAny> {
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
                            value: widget.presentMembers.contains(member.id),
                            onChanged: (bool? value) {
                              setState(() {
                                if (value!) {
                                  widget.presentMembers.add(member.id);
                                  widget.absentMembers.remove(member.id);
                                } else {
                                  widget.presentMembers.remove(member.id);
                                  widget.absentMembers.add(member.id);
                                }
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
