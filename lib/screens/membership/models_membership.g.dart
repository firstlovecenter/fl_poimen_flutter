// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models_membership.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Member _$MemberFromJson(Map<String, dynamic> json) {
  return Member(
    id: json['id'] as String,
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    fullName: json['fullName'] as String,
    pictureUrl: json['pictureUrl'] as String,
    gender: Map<String, String>.from(json['gender'] as Map),
    dob: Map<String, String>.from(json['dob'] as Map),
    phoneNumber: json['phoneNumber'] as String,
  )..typename = json['typename'] as String;
}

Map<String, dynamic> _$MemberToJson(Member instance) => <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'fullName': instance.fullName,
      'pictureUrl': instance.pictureUrl,
      'gender': instance.gender,
      'dob': instance.dob,
      'phoneNumber': instance.phoneNumber,
    };

ChurchForMemberList _$ChurchForMemberListFromJson(Map<String, dynamic> json) {
  return ChurchForMemberList(
    id: json['id'] as String,
    name: json['name'] as String,
    sheep: (json['sheep'] as List<dynamic>)
        .map((e) => Member.fromJson(e as Map<String, dynamic>))
        .toList(),
    goats: (json['goats'] as List<dynamic>)
        .map((e) => Member.fromJson(e as Map<String, dynamic>))
        .toList(),
    deer: (json['deer'] as List<dynamic>)
        .map((e) => Member.fromJson(e as Map<String, dynamic>))
        .toList(),
  )..typename = json['typename'] as String;
}

Map<String, dynamic> _$ChurchForMemberListToJson(
        ChurchForMemberList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'name': instance.name,
      'sheep': instance.sheep,
      'goats': instance.goats,
      'deer': instance.deer,
    };
