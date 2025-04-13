import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:poimen/screens/membership/registration/gql_registration.dart';
import 'package:poimen/screens/membership/registration/models_registration.dart';
import 'package:poimen/services/auth_service.dart';
import 'package:poimen/services/cloudinary_service.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/alert_box.dart';
import 'package:poimen/widgets/image_upload_button.dart';
import 'package:poimen/widgets/location_picker_button.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:poimen/widgets/searchable_dropdown/searchable_dropdown.dart';
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

  // State for Bacenta and Basonta dropdowns
  List<BacentaOption> _bacentaOptions = [];
  BacentaOption? _selectedBacenta;
  bool _isLoadingBacentas = false;
  String? _bacentaError;

  List<BasontaOption> _basontaOptions = [];
  BasontaOption? _selectedBasonta;
  bool _isLoadingBasontas = false;
  String? _basontaError;

  final TextEditingController _dobController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize any required state
  }

  // Function to search for bacentas
  void searchBacentas(String searchKey) {
    if (searchKey.isEmpty) {
      setState(() {
        _bacentaOptions = [];
        _isLoadingBacentas = false;
      });
      return;
    }

    setState(() {
      _isLoadingBacentas = true;
      _bacentaError = null;
    });

    // Get the current user's ID from AuthService
    final rawUserId = AuthService.instance.profile?.sub;

    // Ensure we have a valid user ID
    if (rawUserId == null || rawUserId.isEmpty) {
      setState(() {
        _bacentaError = 'User not authenticated';
        _isLoadingBacentas = false;
      });
      return;
    }

    // Remove "auth0|" prefix from the user ID if it exists
    final userId =
        rawUserId.startsWith('auth0|') ? rawUserId.replaceFirst('auth0|', '') : rawUserId;

    // Execute the GraphQL query
    final GraphQLClient client = GraphQLProvider.of(context).value;
    client
        .query(
      QueryOptions(
        document: memberBacentaSearchQuery,
        variables: {
          'id': userId, // Using the cleaned userId without the auth0| prefix
          'key': searchKey,
        },
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    )
        .then((result) {
      if (result.hasException) {
        setState(() {
          _bacentaError =
              result.exception?.graphqlErrors.first.message ?? 'Error searching bacentas';
          _isLoadingBacentas = false;
        });
        return;
      }

      final data = result.data;
      if (data == null || data['members'] == null || data['members'].isEmpty) {
        setState(() {
          _bacentaOptions = [];
          _isLoadingBacentas = false;
        });
        return;
      }

      final bacentaResults = data['members'][0]['bacentaSearch'] as List<dynamic>;
      final bacentas = bacentaResults
          .map((item) => BacentaOption.fromJson(item as Map<String, dynamic>))
          .toList();

      setState(() {
        _bacentaOptions = bacentas;
        _isLoadingBacentas = false;
      });
    }).catchError((error) {
      setState(() {
        _bacentaError = 'Error searching bacentas: $error';
        _isLoadingBacentas = false;
      });
    });
  }

  // Function to load basontas for a campus
  void loadBasontas(String campusId) {
    if (campusId.isEmpty) {
      setState(() {
        _basontaOptions = [];
        _isLoadingBasontas = false;
      });
      return;
    }

    setState(() {
      _isLoadingBasontas = true;
      _basontaError = null;
    });

    // Execute the GraphQL query
    final GraphQLClient client = GraphQLProvider.of(context).value;
    client
        .query(
      QueryOptions(
        document: getCampusBasontasQuery,
        variables: {
          'id': campusId,
        },
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    )
        .then((result) {
      if (result.hasException) {
        setState(() {
          _basontaError = result.exception?.graphqlErrors.first.message ?? 'Error loading basontas';
          _isLoadingBasontas = false;
        });
        return;
      }

      final data = result.data;
      if (data == null || data['campuses'] == null || data['campuses'].isEmpty) {
        setState(() {
          _basontaOptions = [];
          _isLoadingBasontas = false;
        });
        return;
      }

      final basontaResults = data['campuses'][0]['basontas'] as List<dynamic>;
      final basontas = basontaResults
          .map((item) => BasontaOption.fromJson(item as Map<String, dynamic>))
          .toList();

      setState(() {
        _basontaOptions = basontas;
        _isLoadingBasontas = false;
      });
    }).catchError((error) {
      setState(() {
        _basontaError = 'Error loading basontas: $error';
        _isLoadingBasontas = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final churchState = context.watch<SharedState>();

    // Responsive sizing
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;
    final isDesktop = size.width > 900;

    // Theme detection
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    // Set theme adaptive colors
    final primaryColor = isDarkMode ? PoimenTheme.brand : PoimenTheme.brandTextPrimary;
    final textColor = isDarkMode ? Colors.white : Colors.black87;
    final cardColor = isDarkMode ? Colors.grey[800] : Colors.white;
    final borderColor = isDarkMode ? Colors.grey[700] : Colors.grey[300];
    final hintColor = isDarkMode ? Colors.grey[400] : Colors.grey[600];

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

    // Input decoration for form fields with full borders
    InputDecoration getInputDecoration({
      required String labelText,
      String? hintText,
      required Icon prefixIcon,
      Widget? suffixIcon,
    }) {
      // Create a smaller version of the prefix icon
      final Icon smallerPrefixIcon = Icon(
        prefixIcon.icon,
        size: 16, // Reduced size (approximately half of default)
        color: prefixIcon.color,
      );

      // Create a smaller version of the suffix icon if it's an Icon
      Widget? smallerSuffixIcon;
      if (suffixIcon is Icon) {
        smallerSuffixIcon = Icon(
          (suffixIcon).icon,
          size: 16, // Reduced size (approximately half of default)
          color: (suffixIcon).color,
        );
      } else if (suffixIcon is IconButton) {
        // If it's an IconButton, create a new one with a smaller icon
        smallerSuffixIcon = IconButton(
          icon: Icon(
            ((suffixIcon).icon as Icon).icon,
            size: 16, // Reduced size (approximately half of default)
            color: ((suffixIcon).icon as Icon).color,
          ),
          onPressed: (suffixIcon).onPressed,
        );
      } else {
        smallerSuffixIcon = suffixIcon;
      }

      return InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: smallerPrefixIcon,
        suffixIcon: smallerSuffixIcon,
        prefixIconConstraints: const BoxConstraints(minWidth: 40, minHeight: 40),
        suffixIconConstraints: const BoxConstraints(minWidth: 40, minHeight: 40),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: borderColor!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        filled: true,
        fillColor: isDarkMode ? Colors.grey[850] : Colors.grey[50],
      );
    }

    // Create a responsive form layout
    Widget buildFormContent() {
      if (isTablet || isDesktop) {
        // Enhanced layout for tablet and desktop
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card with profile picture and header
            Card(
              elevation: 2,
              margin: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              color: cardColor,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  children: [
                    // Profile picture section
                    Column(
                      children: [
                        ImageUploadButton(
                          preset: 'member_pictures',
                          setPictureUrl: (url) {
                            setState(() {
                              _pictureUrl = url;
                            });
                          },
                          initialImageUrl: _pictureUrl,
                          child: CircleAvatar(
                            radius: isDesktop ? 80 : 70,
                            backgroundColor: isDarkMode ? Colors.grey[700] : Colors.grey[200],
                            backgroundImage:
                                _pictureUrl.isNotEmpty ? NetworkImage(_pictureUrl) : null,
                            child: _pictureUrl.isEmpty
                                ? Icon(Icons.add_a_photo,
                                    size: isDesktop ? 50 : 40,
                                    color: isDarkMode ? Colors.grey[400] : Colors.grey)
                                : null,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Profile Picture',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: isDesktop ? 16 : 14,
                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 32),

                    // Registration header and guidance
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Member Registration',
                            style: TextStyle(
                              fontSize: isDesktop ? 28 : 24,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Please fill in the member details below. Fields marked with * are required.',
                            style: TextStyle(
                              fontSize: isDesktop ? 16 : 14,
                              color: hintColor,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Icon(FontAwesomeIcons.circleInfo, size: 16, color: primaryColor),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Adding a profile picture helps with identification and builds community connection.',
                                  style: TextStyle(
                                    fontSize: isDesktop ? 14 : 12,
                                    fontStyle: FontStyle.italic,
                                    color: textColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Two-column form layout
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left column - Personal Information
                Expanded(
                  child: Card(
                    elevation: 2,
                    margin: const EdgeInsets.only(right: 8, bottom: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    color: cardColor,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(FontAwesomeIcons.userPen, color: primaryColor),
                              const SizedBox(width: 12),
                              Text(
                                'Personal Information',
                                style: TextStyle(
                                  fontSize: isDesktop ? 20 : 18,
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            height: 30,
                            color: borderColor,
                          ),

                          // First Name
                          TextFormField(
                            decoration: getInputDecoration(
                              labelText: 'First Name *',
                              hintText: 'Enter first name',
                              prefixIcon: const Icon(FontAwesomeIcons.user),
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
                          const SizedBox(height: 20),

                          // Middle Name
                          TextFormField(
                            decoration: getInputDecoration(
                              labelText: 'Middle Name',
                              hintText: 'Enter middle name (optional)',
                              prefixIcon: const Icon(FontAwesomeIcons.user),
                            ),
                            onSaved: (value) {
                              _formData.middleName = value ?? '';
                            },
                          ),
                          const SizedBox(height: 20),

                          // Last Name
                          TextFormField(
                            decoration: getInputDecoration(
                              labelText: 'Last Name *',
                              hintText: 'Enter last name',
                              prefixIcon: const Icon(FontAwesomeIcons.user),
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
                          const SizedBox(height: 20),

                          // Gender
                          DropdownButtonFormField<String>(
                            decoration: getInputDecoration(
                              labelText: 'Gender *',
                              prefixIcon: const Icon(FontAwesomeIcons.venusMars),
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
                            dropdownColor: isDarkMode ? Colors.grey[800] : Colors.white,
                          ),
                          const SizedBox(height: 20),

                          // Date of Birth
                          TextFormField(
                            controller: _dobController,
                            decoration: getInputDecoration(
                              labelText: 'Date of Birth *',
                              hintText: 'YYYY-MM-DD',
                              prefixIcon: const Icon(FontAwesomeIcons.calendar),
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.calendar_today),
                                onPressed: () async {
                                  final DateTime? picked = await showDatePicker(
                                    context: context,
                                    initialDate:
                                        DateTime.now().subtract(const Duration(days: 365 * 18)),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime.now(),
                                    builder: (context, child) {
                                      return Theme(
                                        data: Theme.of(context).copyWith(
                                          colorScheme: ColorScheme.light(
                                            primary: primaryColor,
                                          ),
                                        ),
                                        child: child!,
                                      );
                                    },
                                  );
                                  if (picked != null) {
                                    setState(() {
                                      _formData.dob = DateFormat('yyyy-MM-dd')
                                          .format(picked); // Update the form data
                                      _dobController.text = _formData.dob; // Update the input box
                                    });
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
                          const SizedBox(height: 20),

                          // Marital Status
                          DropdownButtonFormField<String>(
                            decoration: getInputDecoration(
                              labelText: 'Marital Status *',
                              prefixIcon: const Icon(FontAwesomeIcons.ring),
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
                            dropdownColor: isDarkMode ? Colors.grey[800] : Colors.white,
                          ),
                          const SizedBox(height: 20),

                          // Occupation
                          TextFormField(
                            decoration: getInputDecoration(
                              labelText: 'Occupation',
                              hintText: 'Enter occupation (optional)',
                              prefixIcon: const Icon(FontAwesomeIcons.briefcase),
                            ),
                            onSaved: (value) {
                              _formData.occupation = value ?? '';
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Right column - Contact & Location Information
                Expanded(
                  child: Card(
                    elevation: 2,
                    margin: const EdgeInsets.only(left: 8, bottom: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    color: cardColor,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(FontAwesomeIcons.addressBook, color: primaryColor),
                              const SizedBox(width: 12),
                              Text(
                                'Contact & Location',
                                style: TextStyle(
                                  fontSize: isDesktop ? 20 : 18,
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            height: 30,
                            color: borderColor,
                          ),

                          // Phone Number
                          TextFormField(
                            decoration: getInputDecoration(
                              labelText: 'Phone Number *',
                              hintText: 'Enter phone number',
                              prefixIcon: const Icon(FontAwesomeIcons.phone),
                            ),
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter phone number';
                              }
                              final phoneRegex =
                                  RegExp(r'^[+][(]{0,1}[1-9]{1,4}[)]{0,1}[-\s/0-9]*$');
                              if (!phoneRegex.hasMatch(value)) {
                                return 'Please enter a valid phone number';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _formData.phoneNumber = value ?? '';
                            },
                          ),
                          const SizedBox(height: 20),

                          // WhatsApp Number
                          TextFormField(
                            decoration: getInputDecoration(
                              labelText: 'WhatsApp Number *',
                              hintText: 'Enter WhatsApp number',
                              prefixIcon: const Icon(FontAwesomeIcons.whatsapp),
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
                          const SizedBox(height: 20),

                          // Email Address
                          TextFormField(
                            decoration: getInputDecoration(
                              labelText: 'Email Address',
                              hintText: 'Enter email address (optional)',
                              prefixIcon: const Icon(FontAwesomeIcons.envelope),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (value) {
                              _formData.email = value;
                            },
                          ),
                          const SizedBox(height: 20),

                          // Visitation Area
                          TextFormField(
                            decoration: getInputDecoration(
                              labelText: 'Visitation Area *',
                              hintText: 'Enter area of residence',
                              prefixIcon: const Icon(FontAwesomeIcons.locationDot),
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
                          const SizedBox(height: 40),

                          // Bacenta Searchable Dropdown
                          SearchableDropdown<BacentaOption>(
                            label: 'Bacenta',
                            hintText: 'Search for a bacenta',
                            value: _selectedBacenta,
                            items: _bacentaOptions,
                            onChanged: (BacentaOption? value) {
                              setState(() {
                                _selectedBacenta = value;
                                if (value != null) {
                                  _formData.bacentaId = value.id;

                                  // If the bacenta's governorship has a campus ID, load basontas
                                  if (value.governorship != null) {
                                    // Assuming campusId is available in governorship
                                    // In a real app, you might need to make another query to get the campusId
                                    String campusId = value.governorship!.id;
                                    loadBasontas(campusId);
                                  } else {
                                    // Clear basontas if no governorship/campus
                                    setState(() {
                                      _basontaOptions = [];
                                      _selectedBasonta = null;
                                    });
                                  }
                                }
                              });
                            },
                            onSearch: searchBacentas,
                            isLoading: _isLoadingBacentas,
                            errorText: _bacentaError,
                            prefixIcon: const Icon(FontAwesomeIcons.church),
                            isRequired: true,
                            noItemsFoundText: 'No bacentas found. Try a different search term.',
                          ),
                          const SizedBox(height: 20),

                          // Basonta Searchable Dropdown - appears only if a bacenta with governorship is selected
                          if (_selectedBacenta != null && _selectedBacenta!.governorship != null)
                            SearchableDropdown<BasontaOption>(
                              label: 'Basonta',
                              hintText: 'Select a basonta',
                              value: _selectedBasonta,
                              items: _basontaOptions,
                              onChanged: (BasontaOption? value) {
                                setState(() {
                                  _selectedBasonta = value;
                                  if (value != null) {
                                    _formData.basontaId = value.id;
                                  } else {
                                    _formData.basontaId = '';
                                  }
                                });
                              },
                              onSearch: (String searchKey) {
                                // For basontas, we just filter the existing list
                                // No need to make a new query since we already have all basontas
                              },
                              isLoading: _isLoadingBasontas,
                              errorText: _basontaError,
                              prefixIcon: const Icon(FontAwesomeIcons.peopleGroup),
                              noItemsFoundText: 'No basontas available for this campus.',
                            ),

                          // Additional information hint
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: isDarkMode ? Colors.grey[850] : Colors.grey[100],
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: borderColor!,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.circleInfo,
                                  size: 18,
                                  color: primaryColor,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    'All information is kept confidential and will only be used for church activities and pastoral care.',
                                    style: TextStyle(
                                      fontSize: isDesktop ? 14 : 13,
                                      fontStyle: FontStyle.italic,
                                      color: textColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Submit button - removed card and centered directly
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  SizedBox(
                    width: isDesktop ? 300 : 250,
                    child: SubmitButtonText(
                      text: 'Register Member',
                      isSubmitting: _isSubmitting,
                      onPressed: submitForm,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'After registration, you will be redirected to the member details page.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isDesktop ? 14 : 12,
                      color: hintColor,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        );
      } else {
        // Original mobile layout with updated form fields
        return Column(
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
                      backgroundColor: isDarkMode ? Colors.grey[700] : Colors.grey[200],
                      backgroundImage: _pictureUrl.isNotEmpty ? NetworkImage(_pictureUrl) : null,
                      child: _pictureUrl.isEmpty
                          ? Icon(Icons.add_a_photo,
                              size: 40, color: isDarkMode ? Colors.grey[400] : Colors.grey)
                          : null,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Profile Picture',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Personal Information Section
            Text(
              'Personal Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            Divider(color: borderColor),

            const SizedBox(height: 16),

            // First Name
            TextFormField(
              decoration: getInputDecoration(
                labelText: 'First Name *',
                hintText: 'Enter first name',
                prefixIcon: const Icon(FontAwesomeIcons.user),
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
              decoration: getInputDecoration(
                labelText: 'Middle Name',
                hintText: 'Enter middle name (optional)',
                prefixIcon: const Icon(FontAwesomeIcons.user),
              ),
              onSaved: (value) {
                _formData.middleName = value ?? '';
              },
            ),
            const SizedBox(height: 16),

            // Last Name
            TextFormField(
              decoration: getInputDecoration(
                labelText: 'Last Name *',
                hintText: 'Enter last name',
                prefixIcon: const Icon(FontAwesomeIcons.user),
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
              decoration: getInputDecoration(
                labelText: 'Gender *',
                prefixIcon: const Icon(FontAwesomeIcons.venusMars),
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
              dropdownColor: isDarkMode ? Colors.grey[800] : Colors.white,
            ),
            const SizedBox(height: 16),

            // Phone Number
            TextFormField(
              decoration: getInputDecoration(
                labelText: 'Phone Number *',
                hintText: 'Enter phone number',
                prefixIcon: const Icon(FontAwesomeIcons.phone),
              ),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter phone number';
                }
                final phoneRegex = RegExp(r'^[+][(]{0,1}[1-9]{1,4}[)]{0,1}[-\s/0-9]*$');
                if (!phoneRegex.hasMatch(value)) {
                  return 'Please enter a valid phone number';
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
              decoration: getInputDecoration(
                labelText: 'WhatsApp Number *',
                hintText: 'Enter WhatsApp number',
                prefixIcon: const Icon(FontAwesomeIcons.whatsapp),
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
              decoration: getInputDecoration(
                labelText: 'Email Address',
                hintText: 'Enter email address (optional)',
                prefixIcon: const Icon(FontAwesomeIcons.envelope),
              ),
              keyboardType: TextInputType.emailAddress,
              onSaved: (value) {
                _formData.email = value;
              },
            ),
            const SizedBox(height: 16),

            // Date of Birth
            TextFormField(
              controller: _dobController,
              decoration: getInputDecoration(
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
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: ColorScheme.light(
                              primary: primaryColor,
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (picked != null) {
                      setState(() {
                        _formData.dob =
                            DateFormat('yyyy-MM-dd').format(picked); // Update the form data
                        _dobController.text = _formData.dob; // Update the input box
                      });
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
              decoration: getInputDecoration(
                labelText: 'Marital Status *',
                prefixIcon: const Icon(FontAwesomeIcons.ring),
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
              dropdownColor: isDarkMode ? Colors.grey[800] : Colors.white,
            ),
            const SizedBox(height: 16),

            // Occupation
            TextFormField(
              decoration: getInputDecoration(
                labelText: 'Occupation',
                hintText: 'Enter occupation (optional)',
                prefixIcon: const Icon(FontAwesomeIcons.briefcase),
              ),
              onSaved: (value) {
                _formData.occupation = value ?? '';
              },
            ),
            const SizedBox(height: 16),

            // Bacenta Searchable Dropdown
            SearchableDropdown<BacentaOption>(
              label: 'Bacenta',
              hintText: 'Search for a bacenta',
              value: _selectedBacenta,
              items: _bacentaOptions,
              onChanged: (BacentaOption? value) {
                setState(() {
                  _selectedBacenta = value;
                  if (value != null) {
                    _formData.bacentaId = value.id;

                    // If the bacenta's governorship has a campus ID, load basontas
                    if (value.governorship != null) {
                      String campusId = value.governorship!.id;
                      loadBasontas(campusId);
                    } else {
                      // Clear basontas if no governorship/campus
                      setState(() {
                        _basontaOptions = [];
                        _selectedBasonta = null;
                      });
                    }
                  }
                });
              },
              onSearch: searchBacentas,
              isLoading: _isLoadingBacentas,
              errorText: _bacentaError,
              prefixIcon: const Icon(FontAwesomeIcons.church),
              isRequired: true,
              noItemsFoundText: 'No bacentas found. Try a different search term.',
            ),
            const SizedBox(height: 16),

            // Basonta Searchable Dropdown - appears only if a bacenta with governorship is selected
            if (_selectedBacenta != null && _selectedBacenta!.governorship != null)
              Column(
                children: [
                  SearchableDropdown<BasontaOption>(
                    label: 'Basonta',
                    hintText: 'Select a basonta',
                    value: _selectedBasonta,
                    items: _basontaOptions,
                    onChanged: (BasontaOption? value) {
                      setState(() {
                        _selectedBasonta = value;
                        if (value != null) {
                          _formData.basontaId = value.id;
                        } else {
                          _formData.basontaId = '';
                        }
                      });
                    },
                    onSearch: (String searchKey) {
                      // For basontas, we just filter the existing list
                      // No need to make a new query since we already have all basontas
                    },
                    isLoading: _isLoadingBasontas,
                    errorText: _basontaError,
                    prefixIcon: const Icon(FontAwesomeIcons.peopleGroup),
                    noItemsFoundText: 'No basontas available for this campus.',
                  ),
                  const SizedBox(height: 16),
                ],
              ),

            // Location Information Section
            Text(
              'Location Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            Divider(color: borderColor),

            const SizedBox(height: 16),

            // Visitation Area
            TextFormField(
              decoration: getInputDecoration(
                labelText: 'Visitation Area *',
                hintText: 'Enter area of residence',
                prefixIcon: const Icon(FontAwesomeIcons.locationDot),
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
            const SizedBox(height: 32),

            // Submit Button
            Center(
              child: Container(
                width: double.infinity,
                constraints: const BoxConstraints(maxWidth: 300),
                child: SubmitButtonText(
                  text: 'Register Member',
                  isSubmitting: _isSubmitting,
                  onPressed: submitForm,
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        );
      }
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
              child: buildFormContent(),
            ),
          ),
        ),
      ),
    );
  }
}
