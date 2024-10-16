import 'package:json_annotation/json_annotation.dart';
import 'package:poimen/screens/membership/models_membership.dart';
part 'models_defaulters.g.dart';

@JsonSerializable()
class ChurchBySubChurchForAttendanceDefaulters extends Church {
  List<ChurchForAttendanceDefaulters>? governorships;
  List<ChurchForAttendanceDefaulters>? councils;
  List<ChurchForAttendanceDefaulters>? streams;

  ChurchBySubChurchForAttendanceDefaulters({
    this.governorships,
    this.councils,
    this.streams,
  });

  factory ChurchBySubChurchForAttendanceDefaulters.fromJson(Map<String, dynamic> json) =>
      _$ChurchBySubChurchForAttendanceDefaultersFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ChurchBySubChurchForAttendanceDefaultersToJson(this);
}

@JsonSerializable()
class ChurchForAttendanceDefaulters extends Church {
  int fellowshipServiceAttendanceDefaultersCount = 0;
  int fellowshipBussingAttendanceDefaultersCount = 0;
  int? fellowshipCount = 0;
  int? bacentaCount = 0;
  int? governorshipCount = 0;
  int? councilCount = 0;
  int? streamCount = 0;
  int? fellowshipServicesThisWeekCount = 0;
  int? fellowshipBussingLastWeekCount = 0;

  ChurchForAttendanceDefaulters({
    required this.fellowshipServiceAttendanceDefaultersCount,
    required this.fellowshipBussingAttendanceDefaultersCount,
    required this.bacentaCount,
    required this.governorshipCount,
    required this.councilCount,
    required this.streamCount,
    required this.fellowshipServicesThisWeekCount,
    required this.fellowshipBussingLastWeekCount,
  });

  factory ChurchForAttendanceDefaulters.fromJson(Map<String, dynamic> json) =>
      _$ChurchForAttendanceDefaultersFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ChurchForAttendanceDefaultersToJson(this);
}

@JsonSerializable()
class ChurchForServiceAttendanceDefaultersList extends Church {
  List<Church> fellowshipServiceAttendanceDefaulters;

  ChurchForServiceAttendanceDefaultersList({
    required this.fellowshipServiceAttendanceDefaulters,
  });

  factory ChurchForServiceAttendanceDefaultersList.fromJson(Map<String, dynamic> json) =>
      _$ChurchForServiceAttendanceDefaultersListFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ChurchForServiceAttendanceDefaultersListToJson(this);
}

@JsonSerializable()
class ChurchForBussingAttendanceDefaultersList extends Church {
  List<Church> fellowshipBussingAttendanceDefaulters;

  ChurchForBussingAttendanceDefaultersList({
    required this.fellowshipBussingAttendanceDefaulters,
  });

  factory ChurchForBussingAttendanceDefaultersList.fromJson(Map<String, dynamic> json) =>
      _$ChurchForBussingAttendanceDefaultersListFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ChurchForBussingAttendanceDefaultersListToJson(this);
}
