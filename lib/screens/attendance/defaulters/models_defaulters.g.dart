// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models_defaulters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConstituencyAttendanceDefaulters _$ConstituencyAttendanceDefaultersFromJson(
    Map<String, dynamic> json) {
  return ConstituencyAttendanceDefaulters(
    id: json['id'] as String,
    typename: json['typename'] as String,
    fellowshipAttendanceDefaultersCount:
        json['fellowshipAttendanceDefaultersCount'] as int,
    bacentaAttendanceDefaultersCount:
        json['bacentaAttendanceDefaultersCount'] as int,
  );
}

Map<String, dynamic> _$ConstituencyAttendanceDefaultersToJson(
        ConstituencyAttendanceDefaulters instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'fellowshipAttendanceDefaultersCount':
          instance.fellowshipAttendanceDefaultersCount,
      'bacentaAttendanceDefaultersCount':
          instance.bacentaAttendanceDefaultersCount,
    };
