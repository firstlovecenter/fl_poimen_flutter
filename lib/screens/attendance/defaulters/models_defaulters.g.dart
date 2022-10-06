// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models_defaulters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChurchBySubChurchForAttendanceDefaulters
    _$ChurchBySubChurchForAttendanceDefaultersFromJson(
        Map<String, dynamic> json) {
  return ChurchBySubChurchForAttendanceDefaulters(
    constituencies: (json['constituencies'] as List<dynamic>?)
        ?.map((e) =>
            ChurchForAttendanceDefaulters.fromJson(e as Map<String, dynamic>))
        .toList(),
    councils: (json['councils'] as List<dynamic>?)
        ?.map((e) =>
            ChurchForAttendanceDefaulters.fromJson(e as Map<String, dynamic>))
        .toList(),
    streams: (json['streams'] as List<dynamic>?)
        ?.map((e) =>
            ChurchForAttendanceDefaulters.fromJson(e as Map<String, dynamic>))
        .toList(),
  )
    ..id = json['id'] as String
    ..typename = json['typename'] as String
    ..name = json['name'] as String
    ..leader = json['leader'] == null
        ? null
        : MemberForList.fromJson(json['leader'] as Map<String, dynamic>);
}

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

ChurchForAttendanceDefaulters _$ChurchForAttendanceDefaultersFromJson(
    Map<String, dynamic> json) {
  return ChurchForAttendanceDefaulters(
    fellowshipAttendanceDefaultersCount:
        json['fellowshipAttendanceDefaultersCount'] as int,
    bacentaAttendanceDefaultersCount:
        json['bacentaAttendanceDefaultersCount'] as int,
    bacentaCount: json['bacentaCount'] as int?,
    constituencyCount: json['constituencyCount'] as int?,
    councilCount: json['councilCount'] as int?,
    streamCount: json['streamCount'] as int?,
    fellowshipServicesThisWeekCount:
        json['fellowshipServicesThisWeekCount'] as int?,
    bacentaBussingThisWeekCount: json['bacentaBussingThisWeekCount'] as int?,
  )
    ..id = json['id'] as String
    ..typename = json['typename'] as String
    ..name = json['name'] as String
    ..leader = json['leader'] == null
        ? null
        : MemberForList.fromJson(json['leader'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ChurchForAttendanceDefaultersToJson(
        ChurchForAttendanceDefaulters instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'name': instance.name,
      'leader': instance.leader,
      'fellowshipAttendanceDefaultersCount':
          instance.fellowshipAttendanceDefaultersCount,
      'bacentaAttendanceDefaultersCount':
          instance.bacentaAttendanceDefaultersCount,
      'bacentaCount': instance.bacentaCount,
      'constituencyCount': instance.constituencyCount,
      'councilCount': instance.councilCount,
      'streamCount': instance.streamCount,
      'fellowshipServicesThisWeekCount':
          instance.fellowshipServicesThisWeekCount,
      'bacentaBussingThisWeekCount': instance.bacentaBussingThisWeekCount,
    };

ChurchForFellowshipAttendanceDefaultersList
    _$ChurchForFellowshipAttendanceDefaultersListFromJson(
        Map<String, dynamic> json) {
  return ChurchForFellowshipAttendanceDefaultersList(
    fellowshipAttendanceDefaulters:
        (json['fellowshipAttendanceDefaulters'] as List<dynamic>)
            .map((e) => Church.fromJson(e as Map<String, dynamic>))
            .toList(),
  )
    ..id = json['id'] as String
    ..typename = json['typename'] as String
    ..name = json['name'] as String
    ..leader = json['leader'] == null
        ? null
        : MemberForList.fromJson(json['leader'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ChurchForFellowshipAttendanceDefaultersListToJson(
        ChurchForFellowshipAttendanceDefaultersList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'name': instance.name,
      'leader': instance.leader,
      'fellowshipAttendanceDefaulters': instance.fellowshipAttendanceDefaulters,
    };

ChurchForBacentaAttendanceDefaultersList
    _$ChurchForBacentaAttendanceDefaultersListFromJson(
        Map<String, dynamic> json) {
  return ChurchForBacentaAttendanceDefaultersList(
    bacentaAttendanceDefaulters:
        (json['bacentaAttendanceDefaulters'] as List<dynamic>)
            .map((e) => Church.fromJson(e as Map<String, dynamic>))
            .toList(),
  )
    ..id = json['id'] as String
    ..typename = json['typename'] as String
    ..name = json['name'] as String
    ..leader = json['leader'] == null
        ? null
        : MemberForList.fromJson(json['leader'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ChurchForBacentaAttendanceDefaultersListToJson(
        ChurchForBacentaAttendanceDefaultersList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'name': instance.name,
      'leader': instance.leader,
      'bacentaAttendanceDefaulters': instance.bacentaAttendanceDefaulters,
    };
