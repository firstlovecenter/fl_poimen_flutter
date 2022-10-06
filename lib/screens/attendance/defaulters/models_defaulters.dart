import 'package:json_annotation/json_annotation.dart';
import 'package:poimen/screens/membership/models_membership.dart';
part 'models_defaulters.g.dart';

@JsonSerializable()
class ChurchBySubChurchForAttendanceDefaulters extends Church {
  List<ChurchForAttendanceDefaulters>? constituencies;
  List<ChurchForAttendanceDefaulters>? councils;
  List<ChurchForAttendanceDefaulters>? streams;

  ChurchBySubChurchForAttendanceDefaulters({
    this.constituencies,
    this.councils,
    this.streams,
  }) : super(id: '', name: '', typename: '');

  factory ChurchBySubChurchForAttendanceDefaulters.fromJson(Map<String, dynamic> json) =>
      _$ChurchBySubChurchForAttendanceDefaultersFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ChurchBySubChurchForAttendanceDefaultersToJson(this);
}

@JsonSerializable()
class ChurchForAttendanceDefaulters extends Church {
  int fellowshipAttendanceDefaultersCount = 0;
  int bacentaAttendanceDefaultersCount = 0;
  int? constituencyCount = 0;
  int? councilCount = 0;
  int? streamCount = 0;
  int? fellowshipServicesThisWeekCount = 0;
  int? bacentaBussingThisWeekCount = 0;


  ChurchForAttendanceDefaulters({
    required this.fellowshipAttendanceDefaultersCount,
    required this.bacentaAttendanceDefaultersCount,
    required this.constituencyCount,
    required this.councilCount,
    required this.streamCount,
    required this.fellowshipServicesThisWeekCount,
    required this.bacentaBussingThisWeekCount,
  }) : super(id: '', typename: '', name: '');

  factory ChurchForAttendanceDefaulters.fromJson(Map<String, dynamic> json) =>
      _$ChurchForAttendanceDefaultersFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ChurchForAttendanceDefaultersToJson(this);
}

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

@JsonSerializable()
class ChurchForBacentaAttendanceDefaultersList extends Church {
  List<Church> bacentaAttendanceDefaulters;

  ChurchForBacentaAttendanceDefaultersList({
    required this.bacentaAttendanceDefaulters,
  }) : super(id: '', typename: '', name: '');

  factory ChurchForBacentaAttendanceDefaultersList.fromJson(Map<String, dynamic> json) =>
      _$ChurchForBacentaAttendanceDefaultersListFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ChurchForBacentaAttendanceDefaultersListToJson(this);
}
