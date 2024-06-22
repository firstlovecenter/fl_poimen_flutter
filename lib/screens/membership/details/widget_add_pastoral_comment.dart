import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:poimen/screens/membership/details/gql_member_details.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/alert_box.dart';
import 'package:poimen/widgets/submit_button_text.dart';
import 'package:provider/provider.dart';

class WidgetAddPastoralComment extends StatefulHookWidget {
  const WidgetAddPastoralComment({super.key, required this.member});

  final MemberForList member;

  @override
  State<WidgetAddPastoralComment> createState() => _WidgetAddPastoralCommentState();
}

class _WidgetAddPastoralCommentState extends State<WidgetAddPastoralComment> {
  bool loading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    const iconSize = 16.0;
    String pastoralComment = '';
    var churchState = context.watch<SharedState>();
    String level = churchState.church.typename;

    final reportMutation = useMutation(
      MutationOptions(
        document: recordPastoralComment,
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
                      title: 'Pastoral Comment',
                      message: 'Pastoral Comment has been logged successfully!',
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
                  title: 'Error Submitting Pastoral Comment',
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

    return SizedBox(
      height: 30,
      child: ElevatedButton.icon(
        style: ButtonStyle(
          fixedSize: WidgetStateProperty.all<Size>(const Size(100, 30)),
          padding: WidgetStateProperty.all<EdgeInsets>(
              const EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0)),
        ),
        icon: loading == true
            ? const SizedBox(width: iconSize, height: iconSize, child: CircularProgressIndicator())
            : const Icon(
                FontAwesomeIcons.noteSticky,
                size: iconSize,
              ),
        label: const Text(
          'Comment',
          style: TextStyle(fontSize: 12),
        ),
        onPressed: () {
          showBottomSheet(
              context: context,
              builder: (context) {
                return FractionallySizedBox(
                  heightFactor: 0.6,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Center(
                        child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const Padding(padding: EdgeInsets.all(20.0)),
                          Text('Comment on ${widget.member.firstName} ${widget.member.lastName}',
                              style: PoimenTheme.heading2),
                          const Padding(padding: EdgeInsets.all(15.0)),
                          TextFormField(
                            maxLines: 4,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: const InputDecoration(
                              labelText: 'Comment',
                              hintText: 'Write a comment for future shepherds to see',
                            ),
                            onSaved: (String? value) {
                              pastoralComment = value ?? '';
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
                                padding: WidgetStateProperty.all(
                                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                ),
                                shape: WidgetStateProperty.all(
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
                                          'comment': pastoralComment,
                                          'roleLevel': level,
                                          'memberId': widget.member.id,
                                          'cycleId': churchState.pastoralCycle.id
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
                    )),
                  ),
                );
              });
        },
      ),
    );
  }
}
