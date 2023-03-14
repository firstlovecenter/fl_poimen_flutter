import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:poimen/screens/duties/visitation/gql_visitation.dart';
import 'package:poimen/helpers/constants.dart';
import 'package:poimen/models/neo4j.dart';
import 'package:poimen/screens/home/models_home_screen.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/services/cloudinary_service.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/alert_box.dart';
import 'package:poimen/widgets/avatar_with_initials.dart';
import 'package:poimen/widgets/image_upload_button.dart';
import 'package:poimen/widgets/location_picker_button.dart';
import 'package:poimen/widgets/submit_button_text.dart';
import 'package:provider/provider.dart';

class OutstandingVisitationReportForm extends StatefulHookWidget {
  const OutstandingVisitationReportForm({Key? key, required this.member}) : super(key: key);

  final MemberForList member;

  @override
  State<OutstandingVisitationReportForm> createState() => _OutstandingVisitationReportFormState();
}

class _OutstandingVisitationReportFormState extends State<OutstandingVisitationReportForm> {
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
    String visitationReport = '';
    bool locationSet = (location.latitude + location.longitude != 0.0);
    var churchState = Provider.of<SharedState>(context);
    String level = churchState.church.typename;
    PastoralCycle cycle = churchState.pastoralCycle;

    var church = churchState.church;
    var query = logFellowshipVisitationActivity;

    if (church.typename == 'Fellowship') {
      query = logFellowshipVisitationActivity;
    }
    if (church.typename == 'Bacenta') {
      query = logBacentaVisitationActivity;
    }
    if (church.typename == 'Constituency') {
      query = logConstituencyVisitationActivity;
    }
    if (church.typename == 'Council') {
      query = logCouncilVisitationActivity;
    }

    final reportMutation = useMutation(
      MutationOptions(
        document: query,

        // ignore: void_checks
        update: (cache, result) {
          return cache;
        },
        onCompleted: (dynamic resultData) {
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
                      title: 'Visitation Report',
                      message: 'Visitation Report has been logged successfully!',
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
                  title: 'Error Submitting Visitation Report',
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
        height: 700,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    const Padding(padding: EdgeInsets.all(10.0)),
                    Text('Visitation Report', style: PoimenTheme.heading2),
                    const Padding(padding: EdgeInsets.all(10.0)),
                    Row(
                      children: [
                        Hero(
                          tag: 'member-${widget.member.id}',
                          child: AvatarWithInitials(
                            foregroundImage: picture.image,
                            member: widget.member,
                            radius: 35,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(4),
                        ),
                        Text('${widget.member.firstName} ${widget.member.lastName}',
                            style: PoimenTheme.heading2),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.all(8.0)),
                    ImageUploadButton(
                      preset: visitationReportPreset,
                      setPictureUrl: setPictureUrl,
                      child: const Text('Upload Picture'),
                    ),
                    LocationPickerButton(
                      setLocation: setLocation,
                      child: locationSet
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text('Location Set'),
                                Padding(padding: EdgeInsets.all(8.0)),
                                CircleAvatar(
                                  backgroundColor: Colors.green,
                                  radius: 15,
                                  child: Icon(
                                    FontAwesomeIcons.check,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            )
                          : const Text('Get Location'),
                    ),
                    !locationSet
                        ? const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Please set location',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 14,
                                )),
                          )
                        : Container(),
                    const Padding(padding: EdgeInsets.all(8.0)),
                    TextFormField(
                      maxLines: 2,
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
                        onPressed: reportMutation.result.isLoading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate() && locationSet) {
                                  _formKey.currentState!.save();

                                  reportMutation.runMutation({
                                    'latitude': location.latitude,
                                    'longitude': location.longitude,
                                    'picture': _pictureUrl,
                                    'comment': visitationReport,
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
