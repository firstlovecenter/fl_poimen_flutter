import 'package:json_annotation/json_annotation.dart';
import 'package:poimen/models/neo4j.dart';

/// Model class for the member registration form
class MemberRegistrationFormModel {
  String firstName;
  String middleName;
  String lastName;
  String gender;
  String phoneNumber;
  String whatsappNumber;
  String? email;
  String dob;
  String maritalStatus;
  String occupation;
  String pictureUrl;
  String visitationArea;
  String bacentaId;
  String basontaId;

  MemberRegistrationFormModel({
    this.firstName = '',
    this.middleName = '',
    this.lastName = '',
    this.gender = '',
    this.phoneNumber = '',
    this.whatsappNumber = '',
    this.email,
    this.dob = '',
    this.maritalStatus = '',
    this.occupation = '',
    this.pictureUrl = '',
    this.visitationArea = '',
    this.bacentaId = '',
    this.basontaId = '',
  });
}

/// Constants for form dropdowns
class MemberRegistrationConstants {
  static final List<Map<String, String>> genderOptions = [
    {'value': 'Male', 'label': 'Male'},
    {'value': 'Female', 'label': 'Female'},
  ];

  static final List<Map<String, String>> maritalStatusOptions = [
    {'value': 'Single', 'label': 'Single'},
    {'value': 'Married', 'label': 'Married'},
    {'value': 'Widowed', 'label': 'Widowed'},
  ];
}

/// Model for Bacenta option in the dropdown
class BacentaOption {
  final String id;
  final String name;
  final GovernorshipOption? governorship;

  BacentaOption({
    required this.id,
    required this.name,
    this.governorship,
  });

  factory BacentaOption.fromJson(Map<String, dynamic> json) {
    return BacentaOption(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      governorship:
          json['governorship'] != null ? GovernorshipOption.fromJson(json['governorship']) : null,
    );
  }

  @override
  String toString() {
    return governorship != null ? '$name (${governorship?.name})' : name;
  }
}

/// Model for Governorship option
class GovernorshipOption {
  final String id;
  final String name;

  GovernorshipOption({
    required this.id,
    required this.name,
  });

  factory GovernorshipOption.fromJson(Map<String, dynamic> json) {
    return GovernorshipOption(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }
}

/// Model for Basonta option in the dropdown
class BasontaOption {
  final String id;
  final String name;

  BasontaOption({
    required this.id,
    required this.name,
  });

  factory BasontaOption.fromJson(Map<String, dynamic> json) {
    return BasontaOption(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }

  @override
  String toString() {
    return name;
  }
}
