// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models_defaulters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChurchBySubChurchForAttendanceDefaulters _$ChurchBySubChurchForAttendanceDefaultersFromJson(
        Map<String, dynamic> json) =>
    ChurchBySubChurchForAttendanceDefaulters(
      governorships: (json['governorships'] as List<dynamic>?)
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
          : MemberForList.fromJson(json['leader'] as Map<String, dynamic>)
      ..admin = json['admin'] == null
          ? null
          : MemberForList.fromJson(json['admin'] as Map<String, dynamic>);

Map<String, dynamic> _$ChurchBySubChurchForAttendanceDefaultersToJson(
        ChurchBySubChurchForAttendanceDefaulters instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'name': instance.name,
      'leader': instance.leader,
      'admin': instance.admin,
      'governorships': instance.governorships,
      'councils': instance.councils,
      'streams': instance.streams,
    };

ChurchForAttendanceDefaulters _$ChurchForAttendanceDefaultersFromJson(Map<String, dynamic> json) =>
    ChurchForAttendanceDefaulters(
      fellowshipServiceAttendanceDefaultersCount:
          (json['fellowshipServiceAttendanceDefaultersCount'] as num).toInt(),
      fellowshipBussingAttendanceDefaultersCount:
          (json['fellowshipBussingAttendanceDefaultersCount'] as num).toInt(),
      bacentaCount: (json['bacentaCount'] as num?)?.toInt(),
      governorshipCount: (json['governorshipCount'] as num?)?.toInt(),
      councilCount: (json['councilCount'] as num?)?.toInt(),
      streamCount: (json['streamCount'] as num?)?.toInt(),
      fellowshipServicesThisWeekCount: (json['fellowshipServicesThisWeekCount'] as num?)?.toInt(),
      fellowshipBussingLastWeekCount: (json['fellowshipBussingLastWeekCount'] as num?)?.toInt(),
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
      ..fellowshipCount = (json['fellowshipCount'] as num?)?.toInt();

Map<String, dynamic> _$ChurchForAttendanceDefaultersToJson(
        ChurchForAttendanceDefaulters instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'name': instance.name,
      'leader': instance.leader,
      'admin': instance.admin,
      'fellowshipServiceAttendanceDefaultersCount':
          instance.fellowshipServiceAttendanceDefaultersCount,
      'fellowshipBussingAttendanceDefaultersCount':
          instance.fellowshipBussingAttendanceDefaultersCount,
      'fellowshipCount': instance.fellowshipCount,
      'bacentaCount': instance.bacentaCount,
      'governorshipCount': instance.governorshipCount,
      'councilCount': instance.councilCount,
      'streamCount': instance.streamCount,
      'fellowshipServicesThisWeekCount': instance.fellowshipServicesThisWeekCount,
      'fellowshipBussingLastWeekCount': instance.fellowshipBussingLastWeekCount,
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
          : MemberForList.fromJson(json['leader'] as Map<String, dynamic>)
      ..admin = json['admin'] == null
          ? null
          : MemberForList.fromJson(json['admin'] as Map<String, dynamic>);

Map<String, dynamic> _$ChurchForServiceAttendanceDefaultersListToJson(
        ChurchForServiceAttendanceDefaultersList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'name': instance.name,
      'leader': instance.leader,
      'admin': instance.admin,
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
          : MemberForList.fromJson(json['leader'] as Map<String, dynamic>)
      ..admin = json['admin'] == null
          ? null
          : MemberForList.fromJson(json['admin'] as Map<String, dynamic>);

Map<String, dynamic> _$ChurchForBussingAttendanceDefaultersListToJson(
        ChurchForBussingAttendanceDefaultersList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'name': instance.name,
      'leader': instance.leader,
      'admin': instance.admin,
      'fellowshipBussingAttendanceDefaulters': instance.fellowshipBussingAttendanceDefaulters,
    };
