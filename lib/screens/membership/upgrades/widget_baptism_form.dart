import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:poimen/mixins/validation_mixin.dart';
import 'package:poimen/screens/membership/details/widget_scaffold_with_member_avatar.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/submit_button_text.dart';
import 'package:provider/provider.dart';

class BaptismFormWidget extends StatefulWidget {
  const BaptismFormWidget({Key? key, required this.title, required this.baptismMutation})
      : super(key: key);

  final String title;
  final MutationHookResult baptismMutation;

  @override
  State<BaptismFormWidget> createState() => _BaptismFormWidgetState();
}

class _BaptismFormWidgetState extends State<BaptismFormWidget> with ValidationMixin {
  final _formKey = GlobalKey<FormState>();
  String _baptismDate = '';

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
    String hasBaptismVariable = widget.title.replaceAll(' ', '');

    return ScaffoldWithMemberAvatar(
      title: widget.title,
      children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              textField(),
              const Padding(padding: EdgeInsets.all(10)),
              submitButton(
                label: 'Submit',
                onPressed: widget.baptismMutation.result.isLoading
                    ? null
                    : () {
                        if (_baptismDate != '') {
                          widget.baptismMutation.runMutation({
                            'memberId': appState.memberId,
                            'has$hasBaptismVariable': _baptismDate != '',
                            'has${hasBaptismVariable}Date': _baptismDate,
                          });
                        }
                      },
              ),
              const Padding(padding: EdgeInsets.all(4.0)),
              submitButton(
                  label: 'I don\'t remember the date',
                  onPressed: widget.baptismMutation.result.isLoading
                      ? null
                      : () {
                          widget.baptismMutation.runMutation({
                            'memberId': appState.memberId,
                            'has$hasBaptismVariable': true,
                          });
                        }),
              const Padding(padding: EdgeInsets.all(4.0)),
              submitButton(
                label: 'Not been baptised',
                onPressed:
                    widget.baptismMutation.result.isLoading ? null : () => Navigator.pop(context),
                color: PoimenTheme.darkCardColor,
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget textField() {
    return TextFormField(
      controller: dateinput,
      keyboardType: TextInputType.datetime,
      decoration: const InputDecoration(
        labelText: 'Enter Your Baptism Date',
        hintText: '4th November 2021',
      ),
      readOnly: true,
      validator: validateText,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1950),
            lastDate: DateTime.now());

        if (pickedDate != null) {
          String formattedDate = DateFormat('dd MMM yyyy').format(pickedDate);

          setState(() {
            dateinput.text = formattedDate;
            _baptismDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          });
        }
      },
    );
  }

  Widget submitButton({void Function()? onPressed, String label = 'Submit', Color? color}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: widget.baptismMutation.result.isLoading
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
      child: widget.baptismMutation.result.isLoading && label == 'Submit'
          ? const SubmittingButtonText()
          : Text(label),
    );
  }
}
