import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:poimen/screens/attendance/models_services.dart';
import 'package:poimen/screens/attendance/ticker/enums_ticker.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/services/cloudinary_service.dart' as cloudinary_custom;
import 'package:poimen/state/enums.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/attendance_image_carousel.dart';
import 'package:poimen/widgets/avatar_with_initials.dart';
import 'package:poimen/widgets/submit_button_text.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart';

class AttendanceTickerScreen extends StatefulWidget {
  const AttendanceTickerScreen(
      {Key? key,
      required this.church,
      required this.service,
      required this.tickerMutation,
      required this.category})
      : super(key: key);

  final ServiceCategory category;
  final ChurchForMemberListByCategory church;
  final ServiceWithPicture service;
  final MutationHookResult tickerMutation;

  @override
  State<AttendanceTickerScreen> createState() => _AttendanceTickerScreenState();
}

class _AttendanceTickerScreenState extends State<AttendanceTickerScreen> {
  final List<String> _presentMembers = [];

  @override
  Widget build(BuildContext context) {
    var churchState = context.watch<SharedState>();
    final List<String> membership = [
      ...widget.church.sheep.map((sheep) => sheep.id),
      ...widget.church.goats.map((goat) => goat.id),
      ...widget.church.deer.map((deer) => deer.id),
    ];
    String recordId = '';

    if (widget.category == ServiceCategory.bussing) {
      recordId = churchState.bussingRecordId;
    } else if (widget.category == ServiceCategory.service) {
      recordId = churchState.serviceRecordId;
    }

    // You can create a list of widgets and return the widget at the corresponding index
    List<Widget> listWidgets = [
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Summary for ${widget.service.serviceDate.humanReadable}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            Text(
              format(widget.service.serviceDate.date),
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: PoimenTheme.brand, fontSize: 16.0),
            ),
          ],
        ),
      ),
      const Padding(padding: EdgeInsets.all(10.0)),
      AttendanceImageCarousel(membersPicture: widget.service.membersPicture),
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
    ];

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: listWidgets.length,
            itemBuilder: (BuildContext context, int index) {
              // Return the widget at the current index
              return listWidgets[index];
            },
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(80),
          ),
          onPressed: widget.tickerMutation.result.isLoading
              ? null
              : () {
                  if (!validate(context, [recordId])) {
                    return;
                  }

                  final absentMembers =
                      membership.where((member) => !_presentMembers.contains(member)).toList();

                  widget.tickerMutation.runMutation({
                    'bacentaId': churchState.bacentaId,
                    'hubId': churchState.hubId,
                    'presentMembers': _presentMembers,
                    'absentMembers': absentMembers,
                    'recordId': recordId,
                  });
                },
          child: widget.tickerMutation.result.isLoading
              ? const SubmittingButtonText()
              : const Text('Submit'),
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
                            activeColor: PoimenTheme.darkBrand,
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
                              foregroundImage: cloudinary_custom.CloudinaryImage(
                                url: member.pictureUrl,
                                size: cloudinary_custom.ImageSize.xs,
                              ).image,
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
