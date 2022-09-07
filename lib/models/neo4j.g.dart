// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'neo4j.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Neo4jPoint _$Neo4jPointFromJson(Map<String, dynamic> json) {
  return Neo4jPoint(
    latitude: (json['latitude'] as num).toDouble(),
    longitude: (json['longitude'] as num).toDouble(),
  );
}

Map<String, dynamic> _$Neo4jPointToJson(Neo4jPoint instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

TimeGraph _$TimeGraphFromJson(Map<String, dynamic> json) {
  return TimeGraph(
    date: json['date'] as String,
  );
}

Map<String, dynamic> _$TimeGraphToJson(TimeGraph instance) => <String, dynamic>{
      'date': instance.date,
    };

Gender _$GenderFromJson(Map<String, dynamic> json) {
  return Gender(
    gender: _$enumDecode(_$GenderOptionsEnumMap, json['gender']),
  );
}

Map<String, dynamic> _$GenderToJson(Gender instance) => <String, dynamic>{
      'gender': _$GenderOptionsEnumMap[instance.gender],
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$GenderOptionsEnumMap = {
  GenderOptions.Male: 'Male',
  GenderOptions.Female: 'Female',
};
