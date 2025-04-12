import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:poimen/screens/duties/imcl/gql_imcls.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/services/cloudinary_service.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/alert_box.dart';
import 'package:poimen/widgets/avatar_with_initials.dart';
import 'package:poimen/widgets/submit_button_text.dart';

class IMCLReportForm extends StatefulHookWidget {
  const IMCLReportForm({Key? key, required this.member}) : super(key: key);

  final MemberForList member;

  @override
  State<IMCLReportForm> createState() => _IMCLReportFormState();
}

class _IMCLReportFormState extends State<IMCLReportForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _reasonController = TextEditingController();
  final FocusNode _reasonFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Automatically focus the text field when the form appears
    Future.delayed(const Duration(milliseconds: 300), () {
      _reasonFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _reasonController.dispose();
    _reasonFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Check for dark mode
    final mediaQuery = MediaQuery.of(context);
    final brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    // Check for screen size
    final screenSize = mediaQuery.size;
    final isTablet = screenSize.width >= 600 && screenSize.width < 900;
    final isDesktop = screenSize.width >= 900;

    // Define colors based on theme
    final textColor = isDarkMode ? Colors.white : Colors.black87;
    final hintColor = isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600;
    final textFieldBgColor =
        isDarkMode ? Colors.grey.shade800.withOpacity(0.5) : Colors.grey.shade100;
    final borderColor = isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300;

    final reportMutation = useMutation(
      MutationOptions(
        document: recordReasonForMemberAbsence,
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
                  backgroundColor: isDarkMode ? PoimenTheme.darkCardColor : Colors.white,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    constraints: const BoxConstraints(maxHeight: 350),
                    child: AlertBox(
                      type: AlertType.success,
                      title: 'IMCL Report',
                      message: 'IMCL Report has been logged successfully!',
                      buttonText: 'Done',
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
              backgroundColor: isDarkMode ? PoimenTheme.darkCardColor : Colors.white,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                constraints: const BoxConstraints(maxHeight: 350),
                child: AlertBox(
                  type: AlertType.error,
                  title: 'Error Submitting IMCL Report',
                  message: getGQLException(error),
                  buttonText: 'Try Again',
                  onRetry: () => Navigator.of(context).pop(),
                ),
              ),
            );
          },
        ),
      ),
    );

    // Calculate dynamic dimensions
    final contentMaxWidth = isDesktop
        ? 600.0
        : isTablet
            ? 500.0
            : double.infinity;
    final avatarSize = isDesktop
        ? 60.0
        : isTablet
            ? 55.0
            : 50.0;

    return Padding(
      padding: EdgeInsets.only(bottom: mediaQuery.viewInsets.bottom),
      child: Container(
        constraints: BoxConstraints(maxWidth: contentMaxWidth),
        padding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle for the bottom sheet
            Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2.5),
              ),
            ),
            const SizedBox(height: 24),

            // Member info header
            _buildMemberHeader(isDarkMode, isTablet, isDesktop, avatarSize),

            const SizedBox(height: 24),

            // Form section with styled input
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // Title for the form
                  Text(
                    'Reason for Absence',
                    style: TextStyle(
                      fontSize: isDesktop ? 18 : 16,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Form field
                  TextFormField(
                    controller: _reasonController,
                    focusNode: _reasonFocusNode,
                    maxLines: 4,
                    style: TextStyle(
                      fontSize: 16,
                      color: textColor,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Enter the reason why ${widget.member.firstName} missed church...',
                      hintStyle: TextStyle(color: hintColor),
                      filled: true,
                      fillColor: textFieldBgColor,
                      contentPadding: const EdgeInsets.all(16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: borderColor, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: borderColor, width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: PoimenTheme.brand, width: 2.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.red, width: 1.0),
                      ),
                    ),
                    textCapitalization: TextCapitalization.sentences,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a reason for absence';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 24),

                  // Submit button
                  SizedBox(
                    height: 50,
                    child: ElevatedButton.icon(
                      style: ButtonStyle(
                        padding: WidgetStateProperty.all(
                          const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                          if (states.contains(WidgetState.disabled)) {
                            return isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300;
                          }
                          if (states.contains(WidgetState.pressed)) {
                            return isDarkMode
                                ? PoimenTheme.brand.withOpacity(0.7)
                                : PoimenTheme.brand.withOpacity(0.8);
                          }
                          return PoimenTheme.brand;
                        }),
                        elevation: WidgetStateProperty.all(isDarkMode ? 4.0 : 2.0),
                      ),
                      onPressed: reportMutation.result.isLoading
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                reportMutation.runMutation({
                                  'memberId': widget.member.id,
                                  'reason': _reasonController.text,
                                  'roleLevel': 'Fellowship',
                                });
                              }
                            },
                      icon: reportMutation.result.isLoading
                          ? const SizedBox(width: 24, height: 24)
                          : const Icon(
                              FontAwesomeIcons.floppyDisk,
                              size: 16,
                            ),
                      label: reportMutation.result.isLoading
                          ? const SubmittingButtonText()
                          : const Text(
                              'Submit Report',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMemberHeader(bool isDarkMode, bool isTablet, bool isDesktop, double avatarSize) {
    CloudinaryImage picture =
        CloudinaryImage(url: widget.member.pictureUrl, size: ImageSize.normal);

    return Row(
      children: [
        // Member avatar
        AvatarWithInitials(
          foregroundImage: picture.image,
          member: widget.member,
          radius: avatarSize / 2,
        ),
        const SizedBox(width: 16),

        // Member info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.member.firstName} ${widget.member.lastName}',
                style: TextStyle(
                  fontSize: isDesktop ? 20 : 18,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.member.status ?? 'Member',
                style: TextStyle(
                  fontSize: isDesktop ? 16 : 14,
                  color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
