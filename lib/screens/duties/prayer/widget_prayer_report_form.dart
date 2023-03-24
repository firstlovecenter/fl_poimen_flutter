import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:poimen/screens/duties/prayer/gql_prayer.dart';
import 'package:poimen/screens/home/models_home_screen.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/services/cloudinary_service.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/alert_box.dart';
import 'package:poimen/widgets/avatar_with_initials.dart';
import 'package:poimen/widgets/submit_button_text.dart';
import 'package:provider/provider.dart';

class OutstandingPrayerReportForm extends StatefulHookWidget {
  const OutstandingPrayerReportForm({Key? key, required this.member}) : super(key: key);

  final MemberForList member;

  @override
  State<OutstandingPrayerReportForm> createState() => _OutstandingPrayerReportFormState();
}

class _OutstandingPrayerReportFormState extends State<OutstandingPrayerReportForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String prayerReport = '';
    var churchState = Provider.of<SharedState>(context);
    String level = churchState.church.typename;
    PastoralCycle cycle = churchState.pastoralCycle;

    var church = churchState.church;
    var query = logFellowshipPrayerActivity;

    if (church.typename == 'Fellowship') {
      query = logFellowshipPrayerActivity;
    }
    if (church.typename == 'Bacenta') {
      query = logBacentaPrayerActivity;
    }
    if (church.typename == 'Constituency') {
      query = logConstituencyPrayerActivity;
    }
    if (church.typename == 'Council') {
      query = logCouncilPrayerActivity;
    }

    final reportMutation = useMutation(
      MutationOptions(
        document: query,
        // ignore: void_checks
        update: (cache, result) {
          return cache;
        },
        onCompleted: (resultData) {
          if (resultData == null) {
            return;
          }

          if (resultData.isNotEmpty) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    constraints: const BoxConstraints(maxHeight: 350),
                    child: AlertBox(
                      type: AlertType.success,
                      title: 'Prayer Report',
                      message: 'Prayer Report has been logged successfully!',
                      buttonText: 'OK',
                      onRetry: () => // pop two screens from navigator
                          Navigator.of(context).popUntil((route) => route.isFirst),
                    ),
                  ),
                );
              },
            );
          }
        },
        onError: (error) => showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                constraints: const BoxConstraints(maxHeight: 350),
                child: AlertBox(
                  type: AlertType.error,
                  title: 'Error Submitting Prayer Report',
                  message: getGQLException(error),
                  buttonText: 'OK',
                  onRetry: () => Navigator.of(context).pop(),
                ),
              ),
            );
          },
        ),
      ),
    );

    final picture = CloudinaryImage(url: widget.member.pictureUrl, size: ImageSize.lg);

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SizedBox(
        height: 550,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Text('Prayer Report', style: PoimenTheme.heading2),
                    const Padding(padding: EdgeInsets.all(15.0)),
                    Center(
                      child: Hero(
                        tag: 'member-${widget.member.id}',
                        child: AvatarWithInitials(
                          foregroundImage: picture.image,
                          member: widget.member,
                          radius: 80,
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(15.0)),
                    Text('${widget.member.firstName} ${widget.member.lastName}',
                        style: PoimenTheme.heading2),
                    const Padding(padding: EdgeInsets.all(15.0)),
                    TextFormField(
                      maxLines: 4,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: const InputDecoration(
                        labelText: 'What did you pray about?',
                        hintText: 'What is your report on this prayer?',
                      ),
                      onSaved: (String? value) {
                        prayerReport = value ?? '';
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
                        onPressed: reportMutation.result.isLoading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();

                                  reportMutation.runMutation({
                                    'comment': prayerReport,
                                    'roleLevel': level,
                                    'memberId': widget.member.id,
                                    'cycleId': cycle.id
                                  });
                                }
                              },
                        child: reportMutation.result.isLoading
                            ? const SubmittingButtonText()
                            : const Text('Submit'),
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
