import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:poimen/screens/membership/details/widget_scaffold_with_member_avatar.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/submit_button_text.dart';
import 'package:provider/provider.dart';

class UnderstandingCampaignWidget extends StatefulWidget {
  const UnderstandingCampaignWidget(
      {Key? key,
      required this.title,
      required this.understandingCampaignMutation,
      required this.graduatedSchools})
      : super(key: key);

  final String title;
  final List<String> graduatedSchools;
  final MutationHookResult understandingCampaignMutation;

  @override
  State<UnderstandingCampaignWidget> createState() => _UnderstandingCampaignWidgetState();
}

class _UnderstandingCampaignWidgetState extends State<UnderstandingCampaignWidget> {
  final _formKey = GlobalKey<FormState>();
  List<String> selectedSchools = [];

  @override
  void initState() {
    selectedSchools = widget.graduatedSchools;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<SharedState>(context);

    const understandingSchools = [
      'School of the Word',
      'School of Victorious Living',
      'School of Solid Foundation',
      'School of Evangelism',
      'School of Apologetics',
    ];

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
                  'Please update the list of schools that this member has graduated',
                ),
              ),
              const Padding(padding: EdgeInsets.all(8.0)),
              ...understandingSchools.map(
                (school) => CheckboxListTile(
                  activeColor: PoimenTheme.darkBrand,
                  checkColor: Colors.white38,
                  value: selectedSchools.contains(school),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        selectedSchools.add(school);
                      } else {
                        selectedSchools.remove(school);
                      }
                    });
                  },
                  title: Text(school),
                ),
              ),
              const Padding(padding: EdgeInsets.all(10)),
              submitButton(
                label: 'Submit',
                onPressed: widget.understandingCampaignMutation.result.isLoading
                    ? null
                    : () {
                        widget.understandingCampaignMutation.runMutation({
                          'memberId': appState.memberId,
                          'graduatedUnderstandingSchools': selectedSchools,
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
        backgroundColor: widget.understandingCampaignMutation.result.isLoading
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
      child: widget.understandingCampaignMutation.result.isLoading
          ? const SubmittingButtonText()
          : Text(label),
    );
  }
}
