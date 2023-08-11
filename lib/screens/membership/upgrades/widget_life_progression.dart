import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:poimen/screens/membership/details/widget_scaffold_with_member_avatar.dart';
import 'package:poimen/screens/membership/upgrades/models_membership_upgrades.dart';
import 'package:poimen/screens/membership/upgrades/utils_member_upgrades.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/submit_button_text.dart';
import 'package:provider/provider.dart';

class LifeProgressionWidget extends StatefulWidget {
  const LifeProgressionWidget({
    Key? key,
    required this.title,
    required this.lifeProgressionMutation,
    required this.member,
  }) : super(key: key);

  final String title;
  final MemberWithLifeProgression member;
  final MutationHookResult lifeProgressionMutation;

  @override
  State<LifeProgressionWidget> createState() => _LifeProgressionWidgetState();
}

class _LifeProgressionWidgetState extends State<LifeProgressionWidget> {
  final _formKey = GlobalKey<FormState>();
  List<ProgressionItem> selectedProgressions = [];

  @override
  void initState() {
    selectedProgressions = lifeProgressionList.where((item) {
      return widget.member.lifeProgression?.toJson()[item.property] == true;
    }).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<SharedState>(context);

    return ScaffoldWithMemberAvatar(
      title: widget.title,
      children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Please update the life progeression milestones of the member',
                ),
              ),
              const Padding(padding: EdgeInsets.all(8.0)),
              ...lifeProgressionList.map(
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
                onPressed: widget.lifeProgressionMutation.result.isLoading
                    ? null
                    : () {
                        widget.lifeProgressionMutation.runMutation({
                          'memberId': appState.memberId,
                          'married': selectedProgressions.any((item) => item.property == 'married'),
                          'childbirth':
                              selectedProgressions.any((item) => item.property == 'childbirth'),
                          'universityEducation': selectedProgressions
                              .any((item) => item.property == 'universityEducation'),
                          'ownsHouseOrBuildingProject': selectedProgressions
                              .any((item) => item.property == 'ownsHouseOrBuildingProject'),
                        });
                      },
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
        backgroundColor: widget.lifeProgressionMutation.result.isLoading
            ? const MaterialStatePropertyAll<Color>(PoimenTheme.darkCardColor)
            : MaterialStatePropertyAll<Color>(color ?? PoimenTheme.brand),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
      child: widget.lifeProgressionMutation.result.isLoading
          ? const SubmittingButtonText()
          : Text(label),
    );
  }
}
