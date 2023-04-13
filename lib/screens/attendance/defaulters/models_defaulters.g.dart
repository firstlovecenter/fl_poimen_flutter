// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models_defaulters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChurchBySubChurchForAttendanceDefaulters _$ChurchBySubChurchForAttendanceDefaultersFromJson(
        Map<String, dynamic> json) =>
    ChurchBySubChurchForAttendanceDefaulters(
      constituencies: (json['constituencies'] as List<dynamic>?)
          ?.map((e) => ChurchForAttendanceDefaulters.fromJson(e as Map<String, dynamic>))
          .toList(),
      councils: (json['councils'] as List<dynamic>?)
          ?.map((e) => ChurchForAttendanceDefaulters.fromJson(e as Map<String, dynamic>))
          .toList(),
      streams: (json['streams'] as List<dynamic>?)
          ?.map((e) => ChurchForAttendanceDefaulters.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..id = json['id'] as String
      ..typename = json['typename'] as String
      ..name = json['name'] as String
      ..leader = json['leader'] == null
          ? null
          : MemberForList.fromJson(json['leader'] as Map<String, dynamic>);

Map<String, dynamic> _$ChurchBySubChurchForAttendanceDefaultersToJson(
        ChurchBySubChurchForAttendanceDefaulters instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'name': instance.name,
      'leader': instance.leader,
      'constituencies': instance.constituencies,
      'councils': instance.councils,
      'streams': instance.streams,
    };

ChurchForAttendanceDefaulters _$ChurchForAttendanceDefaultersFromJson(Map<String, dynamic> json) =>
    ChurchForAttendanceDefaulters(
      fellowshipServiceAttendanceDefaultersCount:
          json['fellowshipServiceAttendanceDefaultersCount'] as int,
      fellowshipBussingAttendanceDefaultersCount:
          json['fellowshipBussingAttendanceDefaultersCount'] as int,
      bacentaCount: json['bacentaCount'] as int?,
      constituencyCount: json['constituencyCount'] as int?,
      councilCount: json['councilCount'] as int?,
      streamCount: json['streamCount'] as int?,
      fellowshipServicesThisWeekCount: json['fellowshipServicesThisWeekCount'] as int?,
      bacentaBussingThisWeekCount: json['bacentaBussingThisWeekCount'] as int?,
    )
      ..id = json['id'] as String
      ..typename = json['typename'] as String
      ..name = json['name'] as String
      ..leader = json['leader'] == null
          ? null
          : MemberForList.fromJson(json['leader'] as Map<String, dynamic>)
      ..fellowshipCount = json['fellowshipCount'] as int?;

Map<String, dynamic> _$ChurchForAttendanceDefaultersToJson(
        ChurchForAttendanceDefaulters instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'name': instance.name,
      'leader': instance.leader,
      'fellowshipServiceAttendanceDefaultersCount':
          instance.fellowshipServiceAttendanceDefaultersCount,
      'fellowshipBussingAttendanceDefaultersCount':
          instance.fellowshipBussingAttendanceDefaultersCount,
      'fellowshipCount': instance.fellowshipCount,
      'bacentaCount': instance.bacentaCount,
      'constituencyCount': instance.constituencyCount,
      'councilCount': instance.councilCount,
      'streamCount': instance.streamCount,
      'fellowshipServicesThisWeekCount': instance.fellowshipServicesThisWeekCount,
      'bacentaBussingThisWeekCount': instance.bacentaBussingThisWeekCount,
    };

ChurchForServiceAttendanceDefaultersList _$ChurchForServiceAttendanceDefaultersListFromJson(
        Map<String, dynamic> json) =>
    ChurchForServiceAttendanceDefaultersList(
      fellowshipServiceAttendanceDefaulters:
          (json['fellowshipServiceAttendanceDefaulters'] as List<dynamic>)
              .map((e) => Church.fromJson(e as Map<String, dynamic>))
              .toList(),
    )
      ..id = json['id'] as String
      ..typename = json['typename'] as String
      ..name = json['name'] as String
      ..leader = json['leader'] == null
          ? null
          : MemberForList.fromJson(json['leader'] as Map<String, dynamic>);

Map<String, dynamic> _$ChurchForServiceAttendanceDefaultersListToJson(
        ChurchForServiceAttendanceDefaultersList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'name': instance.name,
      'leader': instance.leader,
      'fellowshipServiceAttendanceDefaulters': instance.fellowshipServiceAttendanceDefaulters,
    };

ChurchForBussingAttendanceDefaultersList _$ChurchForBussingAttendanceDefaultersListFromJson(
        Map<String, dynamic> json) =>
    ChurchForBussingAttendanceDefaultersList(
      fellowshipBussingAttendanceDefaulters:
          (json['fellowshipBussingAttendanceDefaulters'] as List<dynamic>)
              .map((e) => Church.fromJson(e as Map<String, dynamic>))
              .toList(),
    )
      ..id = json['id'] as String
      ..typename = json['typename'] as String
      ..name = json['name'] as String
      ..leader = json['leader'] == null
          ? null
          : MemberForList.fromJson(json['leader'] as Map<String, dynamic>);

Map<String, dynamic> _$ChurchForBussingAttendanceDefaultersListToJson(
        ChurchForBussingAttendanceDefaultersList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'name': instance.name,
      'leader': instance.leader,
      'fellowshipBussingAttendanceDefaulters': instance.fellowshipBussingAttendanceDefaulters,
    };
