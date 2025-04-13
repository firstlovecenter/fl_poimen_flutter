import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:poimen/screens/duties/visitation/gql_visitation.dart';
import 'package:poimen/helpers/constants.dart';
import 'package:poimen/models/neo4j.dart';
import 'package:poimen/screens/home/models_home_screen.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/screens/duties/visitation/models_visitation.dart';
import 'package:poimen/services/cloudinary_service.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/alert_box.dart';
import 'package:poimen/widgets/avatar_with_initials.dart';
import 'package:poimen/widgets/image_upload_button.dart';
import 'package:poimen/widgets/location_picker_button.dart';
import 'package:poimen/widgets/submit_button_text.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class OutstandingVisitationReportForm extends StatefulHookWidget {
  const OutstandingVisitationReportForm({Key? key, required this.member}) : super(key: key);

  final MemberForList member;

  @override
  State<OutstandingVisitationReportForm> createState() => _OutstandingVisitationReportFormState();
}

class _OutstandingVisitationReportFormState extends State<OutstandingVisitationReportForm>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _pictureUrl = '';
  Neo4jPoint location = Neo4jPoint(latitude: 0.0, longitude: 0.0);
  double latitude = 0.0;
  double longitude = 0.0;
  bool _isSubmitting = false;
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;

  final FocusNode _visitationAreaFocusNode = FocusNode();
  final FocusNode _commentFocusNode = FocusNode();
  final TextEditingController _visitationAreaController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _fadeInAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
    _animationController.forward();

    // Pre-populate visitation area if available
    if (widget.member is OutstandingVisitationForList) {
      final visitationMember = widget.member as OutstandingVisitationForList;
      _visitationAreaController.text = visitationMember.visitationArea;

      // If location is available, set it
      if (visitationMember.location != null) {
        location = visitationMember.location!;
        latitude = location.latitude;
        longitude = location.longitude;
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _visitationAreaFocusNode.dispose();
    _commentFocusNode.dispose();
    _visitationAreaController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  void setPictureUrl(String url) {
    setState(() {
      _pictureUrl = url;
    });
  }

  void setLocation(double latitude, double longitude) {
    setState(() {
      location = Neo4jPoint(latitude: latitude, longitude: longitude);
      this.latitude = latitude;
      this.longitude = longitude;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    // Responsive design variables
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 600;
    final isDesktop = size.width >= 900;

    // Theme detection
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    // Colors based on theme
    final cardColor = isDarkMode ? PoimenTheme.darkCardColor : Colors.white;
    final backgroundColor = isDarkMode ? Colors.black12 : Colors.grey.shade50;
    final textColor = isDarkMode ? Colors.white : Colors.black87;
    final inputFillColor = isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100;
    final borderColor = isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300;

    // Determine appropriate padding based on screen size
    final horizontalPadding = isTablet ? 40.0 : 16.0;

    // Get the church state
    var churchState = context.watch<SharedState>();
    String level = churchState.church.typename;
    PastoralCycle cycle = churchState.pastoralCycle;

    // Set the appropriate GraphQL mutation based on church type
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
        update: (cache, result) => cache,
        onCompleted: (dynamic resultData) {
          setState(() {
            _isSubmitting = false;
          });

          if (resultData == null) return;

          if (resultData.isNotEmpty) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    constraints: const BoxConstraints(maxHeight: 350, maxWidth: 350),
                    child: AlertBox(
                      type: AlertType.success,
                      title: 'Visitation Report',
                      message: 'Visitation Report has been logged successfully!',
                      buttonText: 'OK',
                      onRetry: () => Navigator.of(context).popUntil((route) => route.isFirst),
                    ),
                  ),
                );
              },
            );
          }
        },
        onError: (error) {
          setState(() {
            _isSubmitting = false;
          });

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  constraints: const BoxConstraints(maxHeight: 350, maxWidth: 350),
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
          );
        },
      ),
    );

    final picture = CloudinaryImage(url: widget.member.pictureUrl, size: ImageSize.lg);
    final bool locationSet = (location.latitude + location.longitude != 0.0);

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: horizontalPadding,
        right: horizontalPadding,
      ),
      child: FractionallySizedBox(
        heightFactor: 0.9,
        child: FadeTransition(
          opacity: _fadeInAnimation,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: isDarkMode ? PoimenTheme.darkCardColor : Colors.white,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  padding: const EdgeInsets.all(20.0),
                  child: ListView(
                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 5,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

                            // Title
                            Center(
                              child: Text(
                                'Visitation Report',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Member info
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Hero(
                                  tag: 'member-${widget.member.id}',
                                  child: AvatarWithInitials(
                                    foregroundImage: picture.image,
                                    member: widget.member,
                                    radius: 40,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Flexible(
                                  child: Text(
                                    '${widget.member.firstName} ${widget.member.lastName}',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: textColor,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),

                            // Picture upload section
                            Card(
                              color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: BorderSide(
                                  color: borderColor,
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Section title
                                    Text(
                                      'Upload Photo',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: textColor,
                                      ),
                                    ),
                                    const SizedBox(height: 12),

                                    // Upload button
                                    _pictureUrl.isEmpty
                                        ? Center(
                                            child: ImageUploadButton(
                                              preset: visitationReportPreset,
                                              setPictureUrl: setPictureUrl,
                                              child: Container(
                                                width: double.infinity,
                                                padding: const EdgeInsets.symmetric(vertical: 16.0),
                                                decoration: BoxDecoration(
                                                  color: PoimenTheme.brand,
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                                child: const Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      FontAwesomeIcons.camera,
                                                      color: Colors.white,
                                                      size: 16,
                                                    ),
                                                    SizedBox(width: 8),
                                                    Text(
                                                      'Take Visitation Photo',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        : Column(
                                            children: [
                                              // Show preview of uploaded image
                                              Container(
                                                height: 200,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(12),
                                                  image: DecorationImage(
                                                    image: NetworkImage(_pictureUrl),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 12),

                                              // Change photo button
                                              ImageUploadButton(
                                                preset: visitationReportPreset,
                                                setPictureUrl: setPictureUrl,
                                                child: Container(
                                                  width: double.infinity,
                                                  padding:
                                                      const EdgeInsets.symmetric(vertical: 10.0),
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey.withOpacity(0.2),
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Icon(
                                                        FontAwesomeIcons.rotateRight,
                                                        color: textColor,
                                                        size: 14,
                                                      ),
                                                      const SizedBox(width: 8),
                                                      Text(
                                                        'Change Photo',
                                                        style: TextStyle(
                                                          color: textColor,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Location section
                            Card(
                              color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: BorderSide(
                                  color: borderColor,
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Section title
                                    Text(
                                      'Location',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: textColor,
                                      ),
                                    ),
                                    const SizedBox(height: 12),

                                    // Location status indicator
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12.0, horizontal: 16.0),
                                      decoration: BoxDecoration(
                                        color: locationSet
                                            ? Colors.green.withOpacity(isDarkMode ? 0.3 : 0.1)
                                            : Colors.red.withOpacity(isDarkMode ? 0.3 : 0.1),
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: locationSet ? Colors.green : Colors.red,
                                          width: 1,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            locationSet
                                                ? FontAwesomeIcons.locationDot
                                                : FontAwesomeIcons.locationDot,
                                            color: locationSet ? Colors.green : Colors.red,
                                            size: 16,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            locationSet ? 'Location set' : 'Location not set',
                                            style: TextStyle(
                                              color: locationSet ? Colors.green : Colors.red,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 12),

                                    // Location picker button
                                    ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: PoimenTheme.brand,
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 16),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12.0),
                                        ),
                                        minimumSize: const Size(double.infinity, 50),
                                      ),
                                      onPressed: () {
                                        _showLocationPickerDialog(context);
                                      },
                                      icon: Icon(
                                        locationSet
                                            ? FontAwesomeIcons.penToSquare
                                            : FontAwesomeIcons.locationCrosshairs,
                                        size: 16,
                                      ),
                                      label: Text(
                                        locationSet ? 'Update Location' : 'Set Location',
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ),

                                    // Show coordinates if set
                                    if (locationSet) ...[
                                      const SizedBox(height: 8),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Lat: ${location.latitude.toStringAsFixed(5)}',
                                              style: TextStyle(
                                                  fontSize: 12, color: textColor.withOpacity(0.7)),
                                            ),
                                            Text(
                                              'Long: ${location.longitude.toStringAsFixed(5)}',
                                              style: TextStyle(
                                                  fontSize: 12, color: textColor.withOpacity(0.7)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Form fields
                            Card(
                              color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: BorderSide(
                                  color: borderColor,
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Visit Details',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: textColor,
                                      ),
                                    ),
                                    const SizedBox(height: 16),

                                    // Area field
                                    TextFormField(
                                      controller: _visitationAreaController,
                                      focusNode: _visitationAreaFocusNode,
                                      textCapitalization: TextCapitalization.sentences,
                                      style: TextStyle(color: textColor),
                                      decoration: InputDecoration(
                                        labelText: 'Name of Area',
                                        hintText: 'Put Hostel and Room Number if Student',
                                        labelStyle: TextStyle(color: textColor.withOpacity(0.7)),
                                        hintStyle: TextStyle(color: textColor.withOpacity(0.5)),
                                        filled: true,
                                        fillColor: inputFillColor,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: BorderSide.none,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: BorderSide(
                                            color: borderColor,
                                            width: 1,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: BorderSide(
                                            color: PoimenTheme.brand,
                                            width: 2,
                                          ),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: const BorderSide(
                                            color: Colors.red,
                                            width: 1,
                                          ),
                                        ),
                                        prefixIcon: const Icon(FontAwesomeIcons.house, size: 14),
                                        contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 16,
                                        ),
                                      ),
                                      validator: (String? value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter some text';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 16),

                                    // Comment field
                                    TextFormField(
                                      controller: _commentController,
                                      focusNode: _commentFocusNode,
                                      maxLines: 4,
                                      textCapitalization: TextCapitalization.sentences,
                                      style: TextStyle(color: textColor),
                                      decoration: InputDecoration(
                                        labelText: 'Comment',
                                        hintText: 'What is your report on this visitation?',
                                        labelStyle: TextStyle(color: textColor.withOpacity(0.7)),
                                        hintStyle: TextStyle(color: textColor.withOpacity(0.5)),
                                        filled: true,
                                        fillColor: inputFillColor,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: BorderSide.none,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: BorderSide(
                                            color: borderColor,
                                            width: 1,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: BorderSide(
                                            color: PoimenTheme.brand,
                                            width: 2,
                                          ),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: const BorderSide(
                                            color: Colors.red,
                                            width: 1,
                                          ),
                                        ),
                                        prefixIcon: const Padding(
                                          padding: EdgeInsets.only(bottom: 60),
                                          child: Icon(FontAwesomeIcons.commentDots, size: 14),
                                        ),
                                        contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 16,
                                        ),
                                        alignLabelWithHint: true,
                                      ),
                                      validator: (String? value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter some text';
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Submit button
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: PoimenTheme.brand,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                minimumSize: const Size(double.infinity, 54),
                                elevation: 0,
                              ),
                              onPressed: _isSubmitting || !locationSet || _pictureUrl.isEmpty
                                  ? null
                                  : () {
                                      if (_formKey.currentState!.validate() && locationSet) {
                                        setState(() {
                                          _isSubmitting = true;
                                        });

                                        reportMutation.runMutation({
                                          'latitude': location.latitude,
                                          'longitude': location.longitude,
                                          'visitationArea': _visitationAreaController.text,
                                          'picture': _pictureUrl,
                                          'comment': _commentController.text,
                                          'roleLevel': level,
                                          'memberId': widget.member.id,
                                          'cycleId': cycle.id
                                        });
                                      }
                                    },
                              child: _isSubmitting
                                  ? Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2.5,
                                            valueColor: AlwaysStoppedAnimation<Color>(
                                              Colors.white.withOpacity(0.8),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        const Text(
                                          'Submitting...',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    )
                                  : _pictureUrl.isEmpty || !locationSet
                                      ? Text(
                                          _pictureUrl.isEmpty && !locationSet
                                              ? 'Please upload a photo and set location'
                                              : _pictureUrl.isEmpty
                                                  ? 'Please upload a photo'
                                                  : 'Please set location',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      : const Text(
                                          'Submit Visitation Report',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                            ),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showLocationPickerDialog(BuildContext context) {
    // Theme detection
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white : Colors.black87;
    final backgroundColor = isDarkMode ? Colors.grey.shade800 : Colors.white;
    final inputFillColor = isDarkMode ? Colors.grey.shade700 : Colors.grey.shade100;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: Text(
            'Set Location',
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                initialValue: location.latitude.toString(),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                style: TextStyle(color: textColor),
                decoration: InputDecoration(
                  labelText: 'Latitude',
                  hintText: 'Latitude',
                  filled: true,
                  fillColor: inputFillColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a value';
                  }
                  double? doubleValue = double.tryParse(value);
                  if (doubleValue == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    try {
                      latitude = double.parse(value);
                    } catch (_) {}
                  }
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: location.longitude.toString(),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                style: TextStyle(color: textColor),
                decoration: InputDecoration(
                  labelText: 'Longitude',
                  hintText: 'Longitude',
                  filled: true,
                  fillColor: inputFillColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a value';
                  }
                  double? doubleValue = double.tryParse(value);
                  if (doubleValue == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    try {
                      longitude = double.parse(value);
                    } catch (_) {}
                  }
                },
              ),
              const SizedBox(height: 20),
              LocationPickerButton(
                setLocation: setLocation,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: PoimenTheme.brand,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.locationArrow,
                        color: Colors.white,
                        size: 16,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Use Current Location',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: textColor.withOpacity(0.7),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: PoimenTheme.brand,
              ),
              onPressed: () {
                setLocation(latitude, longitude);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
