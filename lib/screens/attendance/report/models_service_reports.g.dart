// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models_service_reports.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
      membersAbsent: (json['membersAbsent'] as List<dynamic>?)
          ?.map((e) => MemberForList.fromJson(e as Map<String, dynamic>))
          .toList(),
      membersPresent: (json['membersPresent'] as List<dynamic>?)
          ?.map((e) => MemberForList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ServicesForReportToJson(ServicesForReport instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'serviceDate': instance.serviceDate,
      'membersPicture': instance.membersPicture,
      'membersPresentFromFellowship': instance.membersPresentFromFellowship,
      'membersPresent': instance.membersPresent,
      'membersAbsentFromFellowship': instance.membersAbsentFromFellowship,
      'membersAbsent': instance.membersAbsent,
    };
