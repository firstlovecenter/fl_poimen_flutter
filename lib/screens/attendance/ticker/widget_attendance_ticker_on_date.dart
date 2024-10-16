import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:poimen/screens/attendance/ticker/enums_ticker.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/services/cloudinary_service.dart' as cloudinary_custom;
import 'package:poimen/state/enums.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/avatar_with_initials.dart';
import 'package:poimen/widgets/submit_button_text.dart';
import 'package:provider/provider.dart';

class WidgetAttendanceTickerOnDate extends StatefulWidget {
  const WidgetAttendanceTickerOnDate(
      {Key? key, required this.church, required this.tickerMutation, required this.category})
      : super(key: key);

  final ServiceCategory category;
  final ChurchForMemberListByCategory church;
  final MutationHookResult tickerMutation;

  @override
  State<WidgetAttendanceTickerOnDate> createState() => _WidgetAttendanceTickerOnDateState();
}

class _WidgetAttendanceTickerOnDateState extends State<WidgetAttendanceTickerOnDate> {
  final List<String> _presentMembers = [];

  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

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
      const Padding(padding: EdgeInsets.all(10.0)),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          _selectedDate == null ? 'No date selected!' : DateFormat('yMMMEd').format(_selectedDate!),
        ),
      ),
      const SizedBox(height: 20.0),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => _selectDate(context),
          child: const Text('Select date'),
        ),
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
                  if (_selectedDate == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please select a date'),
                      ),
                    );
                    return;
                  }
                  final absentMembers =
                      membership.where((member) => !_presentMembers.contains(member)).toList();

                  widget.tickerMutation.runMutation({
                    'constituencyId': churchState.constituencyId,
                    'hubId': churchState.hubId,
                    'date': _selectedDate.toString().split(' ')[0],
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
