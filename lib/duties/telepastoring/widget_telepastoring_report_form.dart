import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:poimen/duties/telepastoring/gql_telepastoring.dart';
import 'package:poimen/models/neo4j.dart';
import 'package:poimen/screens/home/models_home_screen.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/services/cloudinary_service.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/alert_box.dart';
import 'package:poimen/widgets/avatar_with_initials.dart';
import 'package:provider/provider.dart';

class OutstandingTelepastoringReportForm extends StatefulHookWidget {
  const OutstandingTelepastoringReportForm({Key? key, required this.member}) : super(key: key);

  final MemberForList member;

  @override
  State<OutstandingTelepastoringReportForm> createState() =>
      _OutstandingTelepastoringReportFormState();
}

class _OutstandingTelepastoringReportFormState extends State<OutstandingTelepastoringReportForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _pictureUrl = '';
  Neo4jPoint location = Neo4jPoint(latitude: 0.0, longitude: 0.0);

  void setPictureUrl(String url) {
    setState(() {
      _pictureUrl = url;
    });
  }

  void setLocation(double latitude, double longitude) {
    setState(() {
      location = Neo4jPoint(latitude: latitude, longitude: longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    String telepastoringReport = '';
    bool locationSet = (location.latitude + location.longitude != 0.0);
    var churchState = Provider.of<SharedState>(context);
    String level = churchState.church.typename;
    PastoralCycle cycle = churchState.pastoralCycle;

    final reportMutation = useMutation(
      MutationOptions(
        document: logTelepastoringActivity,

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
            backgroundColor: PoimenTheme.bad,
          ),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Text('Telepastoring Report', style: PoimenTheme.heading2),
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
                      decoration: const InputDecoration(
                        labelText: 'Comment',
                        hintText: 'What is your report on this telepastoring?',
                      ),
                      onSaved: (String? value) {
                        telepastoringReport = value ?? '';
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

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text(
                                  'Submitting...',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                backgroundColor: PoimenTheme.good,
                              ),
                            );

                            reportMutation.runMutation({
                              'latitude': location.latitude,
                              'longitude': location.longitude,
                              'picture': _pictureUrl,
                              'comment': telepastoringReport,
                              'roleLevel': level,
                              'memberId': widget.member.id,
                              'cycleId': cycle.id
                            });
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
