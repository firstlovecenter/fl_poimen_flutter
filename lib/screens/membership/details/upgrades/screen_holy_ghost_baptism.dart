import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:poimen/screens/membership/details/upgrades/gql_member_upgrades.dart';
import 'package:poimen/screens/membership/details/widget_scaffold_with_member_avatar.dart';
import 'package:poimen/mixins/validation_mixin.dart';
import 'package:intl/intl.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/alert_box.dart';
import 'package:provider/provider.dart';

class HolyGhostBaptismScreen extends StatefulHookWidget {
  const HolyGhostBaptismScreen({Key? key}) : super(key: key);

  @override
  State<HolyGhostBaptismScreen> createState() => _HolyGhostBaptismScreenState();
}

class _HolyGhostBaptismScreenState extends State<HolyGhostBaptismScreen> with ValidationMixin {
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

    final holyGhostUpgradeMutation = useMutation(
      MutationOptions(
        document: recordMemberHolyGhostBaptismUpgrade,
        // ignore: void_checks
        update: (cache, result) {
          return cache;
        },
        onCompleted: (resultData) {
          if (resultData == null) {
            return;
          }

          Navigator.of(context).popUntil(ModalRoute.withName('/membership-upgrades'));
        },
      ),
    );

    return ScaffoldWithMemberAvatar(
      title: 'Holy Ghost Baptism',
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
                onPressed: () {
                  if (_baptismDate != '') {
                    holyGhostUpgradeMutation.runMutation({
                      'memberId': appState.memberId,
                      'hasHolyGhostBaptism': _baptismDate != '',
                      'hasHolyGhostBaptismDate': _baptismDate,
                    });

                    var exception = holyGhostUpgradeMutation.result.exception != null
                        ? getGQLException(holyGhostUpgradeMutation.result.exception)
                        : null;

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(exception ?? 'Processing Data')),
                    );
                  }
                },
              ),
              const Padding(padding: EdgeInsets.all(4.0)),
              submitButton(
                  label: 'I don\'t remember the date',
                  onPressed: () {
                    holyGhostUpgradeMutation.runMutation({
                      'memberId': appState.memberId,
                      'hasHolyGhostBaptism': true,
                    });

                    var exception = holyGhostUpgradeMutation.result.exception != null
                        ? getGQLException(holyGhostUpgradeMutation.result.exception)
                        : null;

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(exception ?? 'Processing Data')),
                    );
                  }),
              const Padding(padding: EdgeInsets.all(4.0)),
              submitButton(
                label: 'Not been baptised',
                onPressed: () => Navigator.pop(context),
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
