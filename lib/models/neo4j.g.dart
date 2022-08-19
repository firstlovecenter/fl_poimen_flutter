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
