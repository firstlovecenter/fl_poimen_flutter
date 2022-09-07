import 'package:json_annotation/json_annotation.dart';
import 'package:poimen/state/enums.dart';
part 'neo4j.g.dart';

@JsonSerializable()
class Neo4jPoint {
  double latitude;
  double longitude;

  Neo4jPoint({this.latitude = 0.0, this.longitude = 0.0});

  factory Neo4jPoint.fromJson(Map<String, dynamic> json) => _$Neo4jPointFromJson(json);
  Map<String, dynamic> toJson() => _$Neo4jPointToJson(this);
}

@JsonSerializable()
class TimeGraph {
  String date;

  TimeGraph({this.date = ''});

  factory TimeGraph.fromJson(Map<String, dynamic> json) => _$TimeGraphFromJson(json);
  Map<String, dynamic> toJson() => _$TimeGraphToJson(this);
}

@JsonSerializable()
class Gender {
  GenderOptions gender;

  Gender({this.gender = GenderOptions.Female});

  factory Gender.fromJson(Map<String, dynamic> json) => _$GenderFromJson(json);
  Map<String, dynamic> toJson() => _$GenderToJson(this);
}
