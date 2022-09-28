import 'package:json_annotation/json_annotation.dart';
part 'models_defaulters.g.dart';

@JsonSerializable()
class ConstituencyAttendanceDefaulters {
  String id = '';
  String typename = 'Constituency';
  int fellowshipAttendanceDefaultersCount = 0;
  int bacentaAttendanceDefaultersCount = 0;

  ConstituencyAttendanceDefaulters({
    required this.id,
    required this.typename,
    required this.fellowshipAttendanceDefaultersCount,
    required this.bacentaAttendanceDefaultersCount,
  });

  factory ConstituencyAttendanceDefaulters.fromJson(Map<String, dynamic> json) =>
      _$ConstituencyAttendanceDefaultersFromJson(json);
  Map<String, dynamic> toJson() => _$ConstituencyAttendanceDefaultersToJson(this);
}
