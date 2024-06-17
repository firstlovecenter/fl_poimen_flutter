// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'neo4j.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Neo4jPoint _$Neo4jPointFromJson(Map<String, dynamic> json) => Neo4jPoint(
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$Neo4jPointToJson(Neo4jPoint instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

TimeGraph _$TimeGraphFromJson(Map<String, dynamic> json) =>
    TimeGraph()..date = DateTime.parse(json['date'] as String);

Map<String, dynamic> _$TimeGraphToJson(TimeGraph instance) => <String, dynamic>{
      'date': instance.date.toIso8601String(),
    };

Gender _$GenderFromJson(Map<String, dynamic> json) => Gender(
      gender: $enumDecodeNullable(_$GenderOptionsEnumMap, json['gender']) ??
          GenderOptions.Female,
    );

Map<String, dynamic> _$GenderToJson(Gender instance) => <String, dynamic>{
      'gender': _$GenderOptionsEnumMap[instance.gender]!,
    };

const _$GenderOptionsEnumMap = {
  GenderOptions.Male: 'Male',
  GenderOptions.Female: 'Female',
};

MaritalStatus _$MaritalStatusFromJson(Map<String, dynamic> json) =>
    MaritalStatus(
      status:
          $enumDecodeNullable(_$MaritalStatusOptionsEnumMap, json['status']) ??
              MaritalStatusOptions.Single,
    );

Map<String, dynamic> _$MaritalStatusToJson(MaritalStatus instance) =>
    <String, dynamic>{
      'status': _$MaritalStatusOptionsEnumMap[instance.status]!,
    };

const _$MaritalStatusOptionsEnumMap = {
  MaritalStatusOptions.Single: 'Single',
  MaritalStatusOptions.Married: 'Married',
  MaritalStatusOptions.Widowed: 'Widowed',
};

Occupation _$OccupationFromJson(Map<String, dynamic> json) => Occupation(
      occupation: json['occupation'] as String? ?? '',
    );

Map<String, dynamic> _$OccupationToJson(Occupation instance) =>
    <String, dynamic>{
      'occupation': instance.occupation,
    };
