// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models_service_reports.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServicesForReport _$ServicesForReportFromJson(Map<String, dynamic> json) {
  return ServicesForReport(
    id: json['id'] as String,
    typename: json['typename'] as String,
    serviceDate:
        TimeGraph.fromJson(json['serviceDate'] as Map<String, dynamic>),
    membersPicture: json['membersPicture'] as String,
    membersPresent: (json['membersPresent'] as List<dynamic>)
        .map((e) => MemberForList.fromJson(e as Map<String, dynamic>))
        .toList(),
    membersAbsent: (json['membersAbsent'] as List<dynamic>)
        .map((e) => MemberForList.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ServicesForReportToJson(ServicesForReport instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'serviceDate': instance.serviceDate,
      'membersPicture': instance.membersPicture,
      'membersPresent': instance.membersPresent,
      'membersAbsent': instance.membersAbsent,
    };
