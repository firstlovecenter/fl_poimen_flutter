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
