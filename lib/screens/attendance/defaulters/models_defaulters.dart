import 'package:json_annotation/json_annotation.dart';
import 'package:poimen/screens/membership/models_membership.dart';
part 'models_defaulters.g.dart';

@JsonSerializable()
class ChurchForAttendanceDefaulters extends Church {
  int fellowshipAttendanceDefaultersCount = 0;
  int bacentaAttendanceDefaultersCount = 0;

  ChurchForAttendanceDefaulters({
    required this.fellowshipAttendanceDefaultersCount,
    required this.bacentaAttendanceDefaultersCount,
  }) : super(id: '', typename: '', name: '');

  factory ChurchForAttendanceDefaulters.fromJson(Map<String, dynamic> json) =>
      _$ChurchForAttendanceDefaultersFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ChurchForAttendanceDefaultersToJson(this);
}
