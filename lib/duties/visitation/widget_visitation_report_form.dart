import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:poimen/duties/imcl/gql_imcls.dart';
import 'package:poimen/helpers/constants.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/alert_box.dart';
import 'package:poimen/widgets/image_upload_button.dart';
import 'package:location/location.dart';

class OutstandingVisitationReportForm extends StatefulHookWidget {
  const OutstandingVisitationReportForm({Key? key, required this.member}) : super(key: key);

  final MemberForList member;

  @override
  State<OutstandingVisitationReportForm> createState() => _OutstandingVisitationReportFormState();
}

class _OutstandingVisitationReportFormState extends State<OutstandingVisitationReportForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _pictureUrl = '';

  void setPictureUrl(String url) {
    setState(() {
      _pictureUrl = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    String visitationReport = '';
    var location = Location();
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
        height: 600,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Text('${widget.member.firstName} ${widget.member.lastName}',
                        style: PoimenTheme.heading2),
                    Text('Visitation Report', style: PoimenTheme.heading2),
                    const Padding(padding: EdgeInsets.all(15.0)),
                    ImageUploadButton(
                      preset: visitationReportPreset,
                      setPictureUrl: setPictureUrl,
                      child: const Text('Upload Picture'),
                    ),
                    const Padding(padding: EdgeInsets.all(8.0)),
                    TextFormField(
                      maxLines: 4,
                      decoration: const InputDecoration(
                        labelText: 'Comment',
                        hintText: 'What is your report on this visitation?',
                      ),
                      onSaved: (String? value) {
                        visitationReport = value ?? '';
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
                              'latitude': 0.0,
                              'longitude': 0.0,
                              'pciture': _pictureUrl,
                              'comment': visitationReport,
                              'roleLevel': 'Fellowship',
                              'memberId': widget.member.id,
                              'cycleId': 'cycle-id'
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
