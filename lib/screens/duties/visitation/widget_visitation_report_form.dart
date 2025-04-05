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
  double latitude = 0.0;
  double longitude = 0.0;

  void setPictureUrl(String url) {
    setState(() {
      _pictureUrl = url;
    });
  }

  void setLocation(double latitude, double longitude) {
    setState(() {
      location = Neo4jPoint(latitude: latitude, longitude: longitude);
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    String visitationReport = '';
    String visitationArea = '';

    bool locationSet = (location.latitude + location.longitude != 0.0);
    var churchState = context.watch<SharedState>();
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
    if (church.typename == 'Governorship') {
      query = logGovernorshipVisitationActivity;
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
      child: FractionallySizedBox(
        heightFactor: 0.9,
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
                    const Padding(padding: EdgeInsets.all(8.0)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          ),
                          child: locationSet
                              ? const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
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
                              : const Text('Update Location'),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0)),
                                  title: const Text('Input Location Data'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextFormField(
                                        initialValue: location.latitude.toString(),
                                        keyboardType:
                                            const TextInputType.numberWithOptions(decimal: true),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter a value';
                                          }
                                          double? doubleValue = double.tryParse(value);
                                          if (doubleValue == null) {
                                            return 'Please enter a valid double value';
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          latitude = double.parse(value);
                                        },
                                        decoration: const InputDecoration(
                                          labelText: 'Latitude',
                                          hintText: 'Latitude',
                                        ),
                                      ),
                                      TextFormField(
                                        initialValue: location.longitude.toString(),
                                        keyboardType:
                                            const TextInputType.numberWithOptions(decimal: true),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter a value';
                                          }
                                          double? doubleValue = double.tryParse(value);
                                          if (doubleValue == null) {
                                            return 'Please enter a valid double value';
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          longitude = double.parse(value);
                                        },
                                        decoration: const InputDecoration(
                                          labelText: 'Longitude',
                                          hintText: 'Longitude',
                                        ),
                                      ),
                                      LocationPickerButton(
                                        setLocation: setLocation,
                                        child: locationSet
                                            ? const Text('Change Location')
                                            : const Text('Use Current Locations'),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        setLocation(latitude, longitude);
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
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
                      textCapitalization: TextCapitalization.sentences,
                      decoration: const InputDecoration(
                        labelText: 'Name of Area',
                        hintText: 'Put Hostel and Room Number if Student',
                      ),
                      onSaved: (String? value) {
                        visitationArea = value ?? '';
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      maxLines: 2,
                      textCapitalization: TextCapitalization.sentences,
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
                                    'visitationArea': visitationArea,
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
