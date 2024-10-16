// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models_services.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChurchForMeetingsList _$ChurchForMeetingsListFromJson(
        Map<String, dynamic> json) =>
    ChurchForMeetingsList(
      poimenMeetings: (json['poimenMeetings'] as List<dynamic>)
          .map((e) => ServicesForList.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..id = json['id'] as String
      ..typename = json['typename'] as String
      ..name = json['name'] as String
      ..leader = json['leader'] == null
          ? null
          : MemberForList.fromJson(json['leader'] as Map<String, dynamic>)
      ..admin = json['admin'] == null
          ? null
          : MemberForList.fromJson(json['admin'] as Map<String, dynamic>);

Map<String, dynamic> _$ChurchForMeetingsListToJson(
        ChurchForMeetingsList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'name': instance.name,
      'leader': instance.leader,
      'admin': instance.admin,
      'poimenMeetings': instance.poimenMeetings,
    };

ChurchForServicesList _$ChurchForServicesListFromJson(
        Map<String, dynamic> json) =>
    ChurchForServicesList(
      services: (json['services'] as List<dynamic>)
          .map((e) => ServicesForList.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..id = json['id'] as String
      ..typename = json['typename'] as String
      ..name = json['name'] as String
      ..leader = json['leader'] == null
          ? null
          : MemberForList.fromJson(json['leader'] as Map<String, dynamic>)
      ..admin = json['admin'] == null
          ? null
          : MemberForList.fromJson(json['admin'] as Map<String, dynamic>)
      ..meetings = (json['meetings'] as List<dynamic>?)
          ?.map((e) => ServicesForList.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$ChurchForServicesListToJson(
        ChurchForServicesList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'name': instance.name,
      'leader': instance.leader,
      'admin': instance.admin,
      'services': instance.services,
      'meetings': instance.meetings,
    };

ChurchForBussingList _$ChurchForBussingListFromJson(
        Map<String, dynamic> json) =>
    ChurchForBussingList(
      bussing: (json['bussing'] as List<dynamic>)
          .map((e) => ServicesForList.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..id = json['id'] as String
      ..typename = json['typename'] as String
      ..name = json['name'] as String
      ..leader = json['leader'] == null
          ? null
          : MemberForList.fromJson(json['leader'] as Map<String, dynamic>)
      ..admin = json['admin'] == null
          ? null
          : MemberForList.fromJson(json['admin'] as Map<String, dynamic>);

Map<String, dynamic> _$ChurchForBussingListToJson(
        ChurchForBussingList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'name': instance.name,
      'leader': instance.leader,
      'admin': instance.admin,
      'bussing': instance.bussing,
    };

ServicesForList _$ServicesForListFromJson(Map<String, dynamic> json) =>
    ServicesForList(
      id: json['id'] as String,
      typename: json['typename'] as String,
      attendance: (json['attendance'] as num?)?.toInt(),
      markedAttendance: json['markedAttendance'] as bool,
      serviceDate:
          TimeGraph.fromJson(json['serviceDate'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ServicesForListToJson(ServicesForList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'attendance': instance.attendance,
      'markedAttendance': instance.markedAttendance,
      'serviceDate': instance.serviceDate,
    };

ServiceWithPicture _$ServiceWithPictureFromJson(Map<String, dynamic> json) =>
    ServiceWithPicture(
      id: json['id'] as String,
      typename: json['typename'] as String,
      membersPicture: (json['membersPicture'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      serviceDate:
          TimeGraph.fromJson(json['serviceDate'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ServiceWithPictureToJson(ServiceWithPicture instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'membersPicture': instance.membersPicture,
      'serviceDate': instance.serviceDate,
    };
