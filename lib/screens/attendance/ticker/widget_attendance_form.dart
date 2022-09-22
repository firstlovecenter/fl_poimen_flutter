import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:poimen/helpers/constants.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/services/cloudinary_service.dart' as cloudinary_custom;
import 'package:poimen/state/enums.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/avatar_with_initials.dart';
import 'package:poimen/widgets/image_upload_button.dart';
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
  String _pictureUrl = '';

  void setPictureUrl(String url) {
    setState(() {
      _pictureUrl = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    var churchState = Provider.of<SharedState>(context);
    final List<String> membership = [
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
              const Padding(padding: EdgeInsets.all(15.0)),
              ImageUploadButton(
                preset: membershipAttendancePreset,
                setPictureUrl: setPictureUrl,
                child: const Text('Upload Membership Picture'),
              ),
              const Padding(padding: EdgeInsets.all(8.0)),
              _ShowMembersIfAny(
                members: widget.church.sheep,
                category: MemberCategory.Sheep,
                presentMembers: _presentMembers,
              ),
              _ShowMembersIfAny(
                members: widget.church.goats,
                category: MemberCategory.Goat,
                presentMembers: _presentMembers,
              ),
              _ShowMembersIfAny(
                category: MemberCategory.Deer,
                members: widget.church.deer,
                presentMembers: _presentMembers,
              ),
            ],
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(80),
          ),
          onPressed: () {
            if (!validate(context, [recordId, _pictureUrl])) {
              return;
            }

            final absentMembers =
                membership.where((member) => !_presentMembers.contains(member)).toList();

            widget.tickerMutation.runMutation({
              'presentMembers': _presentMembers,
              'absentMembers': absentMembers,
              'recordId': recordId,
              'membersPicture': _pictureUrl,
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
  const _ShowMembersIfAny({
    Key? key,
    required this.category,
    required this.members,
    required this.presentMembers,
  }) : super(key: key);

  final List<MemberForList> members;
  final MemberCategory category;
  final List<String> presentMembers;

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
                            checkColor: Colors.white38,
                            value: widget.presentMembers.contains(member.id),
                            onChanged: (bool? value) {
                              setState(() {
                                if (value!) {
                                  widget.presentMembers.add(member.id);
                                } else {
                                  widget.presentMembers.remove(member.id);
                                }
                              });
                            },
                            secondary: AvatarWithInitials(
                              member: member,
                              foregroundImage:
                                  cloudinary_custom.CloudinaryImage(url: member.pictureUrl).image,
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

validate(BuildContext context, List<String> fields) {
  if (fields.contains('')) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please upload a picture of the attendance'),
      ),
    );
    return false;
  }

  return true;
}
