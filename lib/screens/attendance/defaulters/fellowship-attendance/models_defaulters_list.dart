import 'package:json_annotation/json_annotation.dart';
import 'package:poimen/screens/membership/models_membership.dart';
part 'models_defaulters_list.g.dart';

@JsonSerializable()
class ChurchForFellowshipAttendanceDefaultersList extends Church {
  List<Church> fellowshipAttendanceDefaulters;

  ChurchForFellowshipAttendanceDefaultersList({
    required this.fellowshipAttendanceDefaulters,
  }) : super(id: '', typename: '', name: '');

  factory ChurchForFellowshipAttendanceDefaultersList.fromJson(Map<String, dynamic> json) =>
      _$ChurchForFellowshipAttendanceDefaultersListFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ChurchForFellowshipAttendanceDefaultersListToJson(this);
}
