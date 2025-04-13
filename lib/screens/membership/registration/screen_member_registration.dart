import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:poimen/screens/membership/registration/gql_registration.dart';
import 'package:poimen/screens/membership/registration/models_registration.dart';
import 'package:poimen/services/cloudinary_service.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/alert_box.dart';
import 'package:poimen/widgets/image_upload_button.dart';
import 'package:poimen/widgets/location_picker_button.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:poimen/widgets/submit_button_text.dart';
import 'package:provider/provider.dart';

class MemberRegistrationScreen extends StatefulHookWidget {
  const MemberRegistrationScreen({Key? key}) : super(key: key);

  @override
  State<MemberRegistrationScreen> createState() => _MemberRegistrationScreenState();
}

class _MemberRegistrationScreenState extends State<MemberRegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final MemberRegistrationFormModel _formData = MemberRegistrationFormModel();
  String _pictureUrl = '';
  bool _isSubmitting = false;
  final bool _showOptionalFields = false;

  @override
  Widget build(BuildContext context) {
    final churchState = context.watch<SharedState>();

    // Responsive sizing
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;
    final isDesktop = size.width > 900;

    // Theme
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    // Create member mutation hook
    final createMemberMutationResult = useMutation(
      MutationOptions(
        document: createMemberMutation,
        onCompleted: (data) {
          setState(() {
            _isSubmitting = false;
          });

          if (data != null && data['CreateMember'] != null) {
            // Set the member ID in the shared state for navigation
            churchState.memberId = data['CreateMember']['id'];

            // Show success message and navigate to details page
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Member registered successfully!'),
                backgroundColor: Colors.green,
              ),
            );

            // Navigate to member details page
            Navigator.of(context).pushReplacementNamed('/member/displaydetails');
          }
        },
        onError: (error) {
          setState(() {
            _isSubmitting = false;
          });

          // Display error message
          showDialog(
            context: context,
            builder: (context) {
              String errorMessage = error?.graphqlErrors.isNotEmpty == true
                  ? error!.graphqlErrors.first.message
                  : 'An error occurred while registering the member.';

              // Special handling for common errors
              if (errorMessage.toLowerCase().contains('email')) {
                errorMessage = 'This email is already registered.';
              } else if (errorMessage.toLowerCase().contains('whatsapp')) {
                errorMessage = 'This WhatsApp number is already registered.';
              }

              return AlertDialog(
                title: const Text('Registration Error'),
                content: Text(errorMessage),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        },
      ),
    );

    // Function to validate and submit the form
    void submitForm() {
      if (_formKey.currentState?.validate() != true) {
        return;
      }

      _formKey.currentState?.save();

      // Set the form to submitting state
      setState(() {
        _isSubmitting = true;
      });

      // Prepare variables for the mutation
      final variables = {
        'firstName': _formData.firstName.trim(),
        'middleName': _formData.middleName.trim(),
        'lastName': _formData.lastName.trim(),
        'gender': _formData.gender,
        'phoneNumber': _formData.phoneNumber,
        'whatsappNumber': _formData.whatsappNumber,
        'email': _formData.email?.trim().toLowerCase(),
        'dob': _formData.dob,
        'maritalStatus': _formData.maritalStatus,
        'occupation': _formData.occupation,
        'pictureUrl': _pictureUrl.isNotEmpty
            ? _pictureUrl
            : 'https://res.cloudinary.com/firstlovecenter/image/upload/v1677793828/person-placeholder.jpg',
        'visitationArea': _formData.visitationArea,
        'bacentaId': churchState.bacentaId,
        'basontaId': _formData.basontaId,
      };

      // Execute the mutation
      createMemberMutationResult.runMutation(variables);
    }

    // Form layout
    return Scaffold(
      appBar: AppBar(
        title: const PageTitle(
          pageTitle: 'Register New Member',
          showBackButton: true,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop
                  ? 32.0
                  : isTablet
                      ? 24.0
                      : 16.0,
              vertical: 16.0,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Picture
                  Center(
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        ImageUploadButton(
                          preset: 'member_pictures',
                          setPictureUrl: (url) {
                            setState(() {
                              _pictureUrl = url;
                            });
                          },
                          initialImageUrl: _pictureUrl,
                          child: CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.grey.shade200,
                            backgroundImage:
                                _pictureUrl.isNotEmpty ? NetworkImage(_pictureUrl) : null,
                            child: _pictureUrl.isEmpty
                                ? const Icon(Icons.add_a_photo, size: 40, color: Colors.grey)
                                : null,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Profile Picture',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Personal Information Section
                  const Text(
                    'Personal Information',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(),

                  // First Name
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'First Name *',
                      hintText: 'Enter first name',
                      prefixIcon: Icon(FontAwesomeIcons.user),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter first name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _formData.firstName = value ?? '';
                    },
                  ),
                  const SizedBox(height: 16),

                  // Middle Name
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Middle Name',
                      hintText: 'Enter middle name (optional)',
                      prefixIcon: Icon(FontAwesomeIcons.user),
                    ),
                    onSaved: (value) {
                      _formData.middleName = value ?? '';
                    },
                  ),
                  const SizedBox(height: 16),

                  // Last Name
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Last Name *',
                      hintText: 'Enter last name',
                      prefixIcon: Icon(FontAwesomeIcons.user),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter last name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _formData.lastName = value ?? '';
                    },
                  ),
                  const SizedBox(height: 16),

                  // Gender
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Gender *',
                      prefixIcon: Icon(FontAwesomeIcons.venusMars),
                    ),
                    items: MemberRegistrationConstants.genderOptions
                        .map((item) => DropdownMenuItem<String>(
                              value: item['value'],
                              child: Text(item['label'] ?? ''),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _formData.gender = value ?? '';
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select gender';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _formData.gender = value ?? '';
                    },
                  ),
                  const SizedBox(height: 16),

                  // Phone Number
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Phone Number *',
                      hintText: 'Enter phone number',
                      prefixIcon: Icon(FontAwesomeIcons.phone),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter phone number';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _formData.phoneNumber = value ?? '';
                    },
                  ),
                  const SizedBox(height: 16),

                  // WhatsApp Number
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'WhatsApp Number *',
                      hintText: 'Enter WhatsApp number',
                      prefixIcon: Icon(FontAwesomeIcons.whatsapp),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter WhatsApp number';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _formData.whatsappNumber = value ?? '';
                    },
                  ),
                  const SizedBox(height: 16),

                  // Email Address
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Email Address',
                      hintText: 'Enter email address (optional)',
                      prefixIcon: Icon(FontAwesomeIcons.envelope),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (value) {
                      _formData.email = value;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Date of Birth
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Date of Birth *',
                      hintText: 'YYYY-MM-DD',
                      prefixIcon: const Icon(FontAwesomeIcons.calendar),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );
                          if (picked != null) {
                            final controller = TextEditingController();
                            controller.text = DateFormat('yyyy-MM-dd').format(picked);
                            // Update the field
                            _formData.dob = controller.text;
                            setState(() {});
                          }
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter date of birth';
                      }
                      // Basic date validation
                      final RegExp dateRegExp = RegExp(r'^\d{4}-\d{2}-\d{2}$');
                      if (!dateRegExp.hasMatch(value)) {
                        return 'Please use format YYYY-MM-DD';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _formData.dob = value ?? '';
                    },
                  ),
                  const SizedBox(height: 16),

                  // Marital Status
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Marital Status *',
                      prefixIcon: Icon(FontAwesomeIcons.ring),
                    ),
                    items: MemberRegistrationConstants.maritalStatusOptions
                        .map((item) => DropdownMenuItem<String>(
                              value: item['value'],
                              child: Text(item['label'] ?? ''),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _formData.maritalStatus = value ?? '';
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select marital status';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _formData.maritalStatus = value ?? '';
                    },
                  ),
                  const SizedBox(height: 16),

                  // Occupation
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Occupation',
                      hintText: 'Enter occupation (optional)',
                      prefixIcon: Icon(FontAwesomeIcons.briefcase),
                    ),
                    onSaved: (value) {
                      _formData.occupation = value ?? '';
                    },
                  ),
                  const SizedBox(height: 24),

                  // Location Information Section
                  const Text(
                    'Location Information',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(),

                  // Visitation Area
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Visitation Area *',
                      hintText: 'Enter area of residence',
                      prefixIcon: Icon(FontAwesomeIcons.locationDot),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter visitation area';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _formData.visitationArea = value ?? '';
                    },
                  ),
                  const SizedBox(height: 16),

                  // Additional Fields for Basonta
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Basonta ID',
                      hintText: 'Enter Basonta ID (optional)',
                      prefixIcon: Icon(FontAwesomeIcons.users),
                    ),
                    onSaved: (value) {
                      _formData.basontaId = value ?? '';
                    },
                  ),
                  const SizedBox(height: 32),

                  // Submit Button
                  Center(
                    child: Container(
                      width: double.infinity,
                      constraints: BoxConstraints(maxWidth: isDesktop ? 400 : double.infinity),
                      child: SubmitButtonText(
                        text: 'Register Member',
                        isSubmitting: _isSubmitting,
                        onPressed: submitForm,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
