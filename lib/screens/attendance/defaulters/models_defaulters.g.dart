// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models_defaulters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChurchForAttendanceDefaulters _$ChurchForAttendanceDefaultersFromJson(
    Map<String, dynamic> json) {
  return ChurchForAttendanceDefaulters(
    fellowshipAttendanceDefaultersCount:
        json['fellowshipAttendanceDefaultersCount'] as int,
    bacentaAttendanceDefaultersCount:
        json['bacentaAttendanceDefaultersCount'] as int,
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
