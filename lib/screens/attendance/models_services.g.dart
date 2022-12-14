// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models_services.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
          : MemberForList.fromJson(json['leader'] as Map<String, dynamic>);

Map<String, dynamic> _$ChurchForServicesListToJson(
        ChurchForServicesList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'name': instance.name,
      'leader': instance.leader,
      'services': instance.services,
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
          : MemberForList.fromJson(json['leader'] as Map<String, dynamic>);

Map<String, dynamic> _$ChurchForBussingListToJson(
        ChurchForBussingList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'name': instance.name,
      'leader': instance.leader,
      'bussing': instance.bussing,
    };

ServicesForList _$ServicesForListFromJson(Map<String, dynamic> json) =>
    ServicesForList(
      id: json['id'] as String,
      typename: json['typename'] as String,
      attendance: json['attendance'] as int?,
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
