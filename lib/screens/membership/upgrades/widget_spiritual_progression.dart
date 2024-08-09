import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:poimen/screens/membership/details/widget_scaffold_with_member_avatar.dart';
import 'package:poimen/screens/membership/upgrades/models_membership_upgrades.dart';
import 'package:poimen/screens/membership/upgrades/utils_member_upgrades.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/submit_button_text.dart';
import 'package:provider/provider.dart';

class SpiritualProgressionWidget extends StatefulWidget {
  const SpiritualProgressionWidget({
    Key? key,
    required this.title,
    required this.spiritualProgressionMutation,
    required this.member,
  }) : super(key: key);

  final String title;
  final MemberWithSpiritualProgression member;
  final MutationHookResult spiritualProgressionMutation;

  @override
  State<SpiritualProgressionWidget> createState() => _SpiritualProgressionWidgetState();
}

class _SpiritualProgressionWidgetState extends State<SpiritualProgressionWidget> {
  final _formKey = GlobalKey<FormState>();
  List<ProgressionItem> selectedProgressions = [];

  @override
  void initState() {
    selectedProgressions = spiritualProgressionList.where((item) {
      return widget.member.spiritualProgression?.toJson()[item.property] == true;
    }).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<SharedState>();

    return ScaffoldWithMemberAvatar(
      title: widget.title,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Please update the spiritual progression of the member',
          ),
        ),
        Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: ListView(
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const Padding(padding: EdgeInsets.all(8.0)),
                    ...spiritualProgressionList.map(
                      (item) => CheckboxListTile(
                          activeColor: PoimenTheme.darkBrand,
                          checkColor: Colors.white38,
                          value: selectedProgressions.contains(item),
                          onChanged: (bool? value) {
                            setState(() {
                              if (value == true) {
                                selectedProgressions.add(item);
                              } else {
                                selectedProgressions.remove(item);
                              }
                            });
                          },
                          title: Text(item.title)),
                    ),
                    const Padding(padding: EdgeInsets.all(10)),
                    submitButton(
                      label: 'Submit',
                      onPressed: widget.spiritualProgressionMutation.result.isLoading
                          ? null
                          : () {
                              widget.spiritualProgressionMutation.runMutation({
                                'memberId': appState.memberId,
                                'salvation': selectedProgressions
                                    .any((item) => item.property == 'salvation'),
                                'waterBaptism': selectedProgressions
                                    .any((item) => item.property == 'waterBaptism'),
                                'holyGhostBaptism': selectedProgressions
                                    .any((item) => item.property == 'holyGhostBaptism'),
                                'newBelieversSchool': selectedProgressions
                                    .any((item) => item.property == 'newBelieversSchool'),
                                'strongChristiansAcademy': selectedProgressions
                                    .any((item) => item.property == 'strongChristiansAcademy'),
                                'understandingSchools1': selectedProgressions
                                    .any((item) => item.property == 'understandingSchools1'),
                                'understandingSchools2': selectedProgressions
                                    .any((item) => item.property == 'understandingSchools2'),
                                'understandingSchools3': selectedProgressions
                                    .any((item) => item.property == 'understandingSchools3'),
                                'attendedCamp1': selectedProgressions
                                    .any((item) => item.property == 'attendedCamp1'),
                                'attendedCamp2': selectedProgressions
                                    .any((item) => item.property == 'attendedCamp2'),
                                'attendedCamp3': selectedProgressions
                                    .any((item) => item.property == 'attendedCamp3'),
                                'foundersIntimateCounselling': selectedProgressions
                                    .any((item) => item.property == 'foundersIntimateCounselling'),
                                'leadPastorIntimateCounselling': selectedProgressions.any(
                                    (item) => item.property == 'leadPastorIntimateCounselling'),
                                'bacentaLeader': selectedProgressions
                                    .any((item) => item.property == 'bacentaLeader'),
                                'basontaLeader': selectedProgressions
                                    .any((item) => item.property == 'basontaLeader'),
                                'creativeArtsLeader': selectedProgressions
                                    .any((item) => item.property == 'creativeArtsLeader'),
                                'hasMakariosCollection': selectedProgressions
                                    .any((item) => item.property == 'hasMakariosCollection'),
                                'hasAudioCollection': selectedProgressions
                                    .any((item) => item.property == 'hasAudioCollection'),
                                'onBacentaWhatsappGroup': selectedProgressions
                                    .any((item) => item.property == 'onBacentaWhatsappGroup'),
                              });
                            },
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget submitButton({void Function()? onPressed, String label = 'Submit', Color? color}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: widget.spiritualProgressionMutation.result.isLoading
            ? const WidgetStatePropertyAll<Color>(PoimenTheme.darkCardColor)
            : WidgetStatePropertyAll<Color>(color ?? PoimenTheme.brand),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
      child: widget.spiritualProgressionMutation.result.isLoading
          ? const SubmittingButtonText()
          : Text(label),
    );
  }
}
