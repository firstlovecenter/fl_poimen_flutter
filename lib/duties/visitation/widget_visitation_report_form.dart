import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:poimen/duties/imcl/gql_imcls.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/alert_box.dart';

class OutstandingVisitationReportForm extends StatefulHookWidget {
  const OutstandingVisitationReportForm({Key? key, required this.member}) : super(key: key);

  final MemberForList member;

  @override
  State<OutstandingVisitationReportForm> createState() => _OutstandingVisitationReportFormState();
}

class _OutstandingVisitationReportFormState extends State<OutstandingVisitationReportForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String reason = '';
    final reportMutation = useMutation(
      MutationOptions(
        document: recordReasonForMemberAbsence,
        // ignore: void_checks
        update: (cache, result) {
          return cache;
        },
        onCompleted: (resultData) {
          Navigator.of(context).pop();
        },
        onError: (error) => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                getGQLException(error),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: PoimenTheme.bad),
        ),
      ),
    );

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SizedBox(
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      maxLines: 2,
                      decoration: InputDecoration(
                        hintText: 'Why Was ${widget.member.firstName} Not In Church?',
                      ),
                      onSaved: (String? value) {
                        reason = value ?? '';
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();

                            reportMutation.runMutation({
                              'memberId': widget.member.id,
                              'reason': reason,
                              'roleLevel': 'Fellowship',
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                          }
                        },
                        child: const Text('Submit'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
