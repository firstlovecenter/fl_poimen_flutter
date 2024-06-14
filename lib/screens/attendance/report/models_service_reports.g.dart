// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models_service_reports.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberForListWithBacenta _$MemberForListWithBacentaFromJson(
        Map<String, dynamic> json) =>
    MemberForListWithBacenta(
      bacenta: Church.fromJson(json['bacenta'] as Map<String, dynamic>),
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

Map<String, dynamic> _$MemberForListWithBacentaToJson(
        MemberForListWithBacenta instance) =>
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
      'bacenta': instance.bacenta,
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
      membersPresentFromBacenta:
          (json['membersPresentFromBacenta'] as List<dynamic>)
              .map((e) => MemberForList.fromJson(e as Map<String, dynamic>))
              .toList(),
      membersAbsentFromBacenta:
          (json['membersAbsentFromBacenta'] as List<dynamic>)
              .map((e) => MemberForList.fromJson(e as Map<String, dynamic>))
              .toList(),
      membersAbsent: (json['membersAbsent'] as List<dynamic>)
          .map((e) =>
              MemberForListWithBacenta.fromJson(e as Map<String, dynamic>))
          .toList(),
      membersPresent: (json['membersPresent'] as List<dynamic>)
          .map((e) =>
              MemberForListWithBacenta.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ServicesForReportToJson(ServicesForReport instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'serviceDate': instance.serviceDate,
      'membersPicture': instance.membersPicture,
      'membersPresentFromBacenta': instance.membersPresentFromBacenta,
      'membersAbsentFromBacenta': instance.membersAbsentFromBacenta,
      'membersPresent': instance.membersPresent,
      'membersAbsent': instance.membersAbsent,
    };

RehearsalsForReport _$RehearsalsForReportFromJson(Map<String, dynamic> json) =>
    RehearsalsForReport(
      id: json['id'] as String,
      typename: json['typename'] as String,
      serviceDate:
          TimeGraph.fromJson(json['serviceDate'] as Map<String, dynamic>),
      membersPicture: (json['membersPicture'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      membersAbsent: (json['membersAbsent'] as List<dynamic>)
          .map((e) =>
              MemberForListWithBacenta.fromJson(e as Map<String, dynamic>))
          .toList(),
      membersPresent: (json['membersPresent'] as List<dynamic>)
          .map((e) =>
              MemberForListWithBacenta.fromJson(e as Map<String, dynamic>))
          .toList(),
      membersAbsentFromHub: (json['membersAbsentFromHub'] as List<dynamic>)
          .map((e) => MemberForList.fromJson(e as Map<String, dynamic>))
          .toList(),
      membersPresentFromHub: (json['membersPresentFromHub'] as List<dynamic>)
          .map((e) => MemberForList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RehearsalsForReportToJson(
        RehearsalsForReport instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'serviceDate': instance.serviceDate,
      'membersPicture': instance.membersPicture,
      'membersAbsent': instance.membersAbsent,
      'membersPresent': instance.membersPresent,
      'membersAbsentFromHub': instance.membersAbsentFromHub,
      'membersPresentFromHub': instance.membersPresentFromHub,
    };
