import 'package:json_annotation/json_annotation.dart';
part 'models_home_screen.g.dart';

@JsonSerializable()
class HomeScreenChurch {
  String id;
  String typename;
  String name;
  int imclTotal;
  int? fellowshipAttendanceDefaultersCount;
  int? outstandingVisitationsCount;
  int? outstandingPrayerCount;
  int? outstandingTelepastoringCount;
  PastoralCycle? currentPastoralCycle;

  HomeScreenChurch({
    required this.id,
    required this.typename,
    required this.name,
    required this.imclTotal,
    this.fellowshipAttendanceDefaultersCount,
    this.outstandingVisitationsCount,
    this.outstandingPrayerCount,
    this.outstandingTelepastoringCount,
    this.currentPastoralCycle,
  });
  factory HomeScreenChurch.fromJson(Map<String, dynamic> json) => _$HomeScreenChurchFromJson(json);
  Map<String, dynamic> toJson() => _$HomeScreenChurchToJson(this);
}

@JsonSerializable()
class PastoralCycle {
  final String id;
  final String typename;
  final String startDate;
  final String endDate;
  final int numberOfDays;

  PastoralCycle({
    required this.id,
    required this.typename,
    required this.startDate,
    required this.endDate,
    required this.numberOfDays,
  });

  factory PastoralCycle.fromJson(Map<String, dynamic> json) => _$PastoralCycleFromJson(json);
  Map<String, dynamic> toJson() => _$PastoralCycleToJson(this);
}
