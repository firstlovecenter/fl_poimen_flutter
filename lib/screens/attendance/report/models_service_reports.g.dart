// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models_service_reports.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberForListWithFellowship _$MemberForListWithFellowshipFromJson(
        Map<String, dynamic> json) =>
    MemberForListWithFellowship(
      fellowship: Church.fromJson(json['fellowship'] as Map<String, dynamic>),
    )
      ..id = json['id'] as String
      ..typename = json['typename'] as String
      ..status = json['status'] as String?
      ..lost = json['lost'] as bool?
      ..firstName = json['firstName'] as String
      ..lastName = json['lastName'] as String
      ..pictureUrl = json['pictureUrl'] as String
      ..phoneNumber = json['phoneNumber'] as String
      ..whatsappNumber = json['whatsappNumber'] as String;

Map<String, dynamic> _$MemberForListWithFellowshipToJson(
        MemberForListWithFellowship instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'status': instance.status,
      'lost': instance.lost,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'pictureUrl': instance.pictureUrl,
      'phoneNumber': instance.phoneNumber,
      'whatsappNumber': instance.whatsappNumber,
      'fellowship': instance.fellowship,
    };

ServicesForReport _$ServicesForReportFromJson(Map<String, dynamic> json) =>
    ServicesForReport(
      id: json['id'] as String,
      typename: json['typename'] as String,
      serviceDate:
          TimeGraph.fromJson(json['serviceDate'] as Map<String, dynamic>),
      membersPicture: (json['membersPicture'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      membersPresentFromFellowship:
          (json['membersPresentFromFellowship'] as List<dynamic>)
              .map((e) => MemberForList.fromJson(e as Map<String, dynamic>))
              .toList(),
      membersAbsentFromFellowship:
          (json['membersAbsentFromFellowship'] as List<dynamic>)
              .map((e) => MemberForList.fromJson(e as Map<String, dynamic>))
              .toList(),
      membersAbsent: (json['membersAbsent'] as List<dynamic>)
          .map((e) =>
              MemberForListWithFellowship.fromJson(e as Map<String, dynamic>))
          .toList(),
      membersPresent: (json['membersPresent'] as List<dynamic>)
          .map((e) =>
              MemberForListWithFellowship.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ServicesForReportToJson(ServicesForReport instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'serviceDate': instance.serviceDate,
      'membersPicture': instance.membersPicture,
      'membersPresentFromFellowship': instance.membersPresentFromFellowship,
      'membersAbsentFromFellowship': instance.membersAbsentFromFellowship,
      'membersPresent': instance.membersPresent,
      'membersAbsent': instance.membersAbsent,
    };
