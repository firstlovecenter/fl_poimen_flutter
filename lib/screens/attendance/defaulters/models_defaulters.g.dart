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
