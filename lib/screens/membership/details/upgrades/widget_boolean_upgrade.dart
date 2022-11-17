import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:poimen/mixins/validation_mixin.dart';
import 'package:poimen/screens/membership/details/widget_scaffold_with_member_avatar.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/alert_box.dart';
import 'package:provider/provider.dart';

class BooleanUpgradeWidget extends StatefulWidget {
  const BooleanUpgradeWidget({Key? key, required this.title, required this.booleanMutation})
      : super(key: key);

  final String title;
  final MutationHookResult booleanMutation;

  @override
  State<BooleanUpgradeWidget> createState() => _BooleanUpgradeWidgetState();
}

class _BooleanUpgradeWidgetState extends State<BooleanUpgradeWidget> with ValidationMixin {
  final _formKey = GlobalKey<FormState>();
  final String _baptismDate = '';

  TextEditingController dateinput = TextEditingController();

  @override
  void initState() {
    dateinput.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<SharedState>(context);
    // replace spaces in title
    String hasUpgradeVariable = widget.title.replaceAll(' ', '');

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
                  label: 'Has the Audio Collections',
                  onPressed: () {
                    widget.booleanMutation.runMutation({
                      'memberId': appState.memberId,
                      'has$hasUpgradeVariable': true,
                    });

                    var exception = widget.booleanMutation.result.exception != null
                        ? getGQLException(widget.booleanMutation.result.exception)
                        : null;

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(exception ?? 'Processing Data')),
                    );
                  }),
              const Padding(padding: EdgeInsets.all(4.0)),
              submitButton(
                label: 'Does Not Have The Collections',
                onPressed: () => Navigator.pop(context),
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
        backgroundColor: MaterialStatePropertyAll<Color>(color ?? PoimenTheme.brand),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
      child: Text(label),
    );
  }
}
