import 'package:json_annotation/json_annotation.dart';
part 'neo4j.g.dart';

@JsonSerializable()
class Neo4jPoint {
  double latitude;
  double longitude;

  Neo4jPoint({this.latitude = 0.0, this.longitude = 0.0});

  factory Neo4jPoint.fromJson(Map<String, dynamic> json) =>
      _$Neo4jPointFromJson(json);
  Map<String, dynamic> toJson() => _$Neo4jPointToJson(this);
}
