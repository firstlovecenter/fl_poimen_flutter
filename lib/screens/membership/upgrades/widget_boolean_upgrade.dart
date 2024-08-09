import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:poimen/mixins/validation_mixin.dart';
import 'package:poimen/screens/membership/details/widget_scaffold_with_member_avatar.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/submit_button_text.dart';
import 'package:provider/provider.dart';

class BooleanUpgradeWidget extends StatefulWidget {
  const BooleanUpgradeWidget(
      {Key? key,
      required this.title,
      required this.upgradeRequirements,
      required this.booleanMutation})
      : super(key: key);

  final String title;
  final String upgradeRequirements;
  final MutationHookResult booleanMutation;

  @override
  State<BooleanUpgradeWidget> createState() => _BooleanUpgradeWidgetState();
}

class _BooleanUpgradeWidgetState extends State<BooleanUpgradeWidget> with ValidationMixin {
  final _formKey = GlobalKey<FormState>();

  TextEditingController dateinput = TextEditingController();

  @override
  void initState() {
    dateinput.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<SharedState>();
    // replace spaces in title
    String hasUpgradeVariable = widget.title.replaceAll(' ', '');
    String label = 'Doesn\'t Have';

    if (widget.title == 'Camp Attendance') {
      label = 'Has Not';
    }

    return ScaffoldWithMemberAvatar(
      title: widget.title,
      children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Padding(padding: EdgeInsets.all(10)),
              const Center(child: Text('Click on the button which applies')),
              const Padding(padding: EdgeInsets.all(8.0)),
              submitButton(
                  label: 'Has ${widget.upgradeRequirements}',
                  onPressed: widget.booleanMutation.result.isLoading
                      ? null
                      : () {
                          widget.booleanMutation.runMutation({
                            'memberId': appState.memberId,
                            'has$hasUpgradeVariable': true,
                          });
                        }),
              const Padding(padding: EdgeInsets.all(4.0)),
              submitButton(
                label: '$label ${widget.upgradeRequirements}',
                onPressed:
                    widget.booleanMutation.result.isLoading ? null : () => Navigator.pop(context),
                color: PoimenTheme.darkCardColor,
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
        backgroundColor: widget.booleanMutation.result.isLoading
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
      child: widget.booleanMutation.result.isLoading && color == null
          ? const SubmittingButtonText()
          : Text(label),
    );
  }
}
