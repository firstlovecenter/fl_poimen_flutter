// ignore_for_file: overridden_fields

import 'package:json_annotation/json_annotation.dart';
import 'package:poimen/screens/home/models_home_screen.dart';
import 'package:poimen/screens/membership/models_membership.dart';
part 'models_pastoral_work_trends.g.dart';

@JsonSerializable()
class VisitationActivityForTrends {
  String id;
  String typename;
  DateTime datetime;

  VisitationActivityForTrends({
    required this.id,
    required this.typename,
    required this.datetime,
  });

  factory VisitationActivityForTrends.fromJson(Map<String, dynamic> json) =>
      _$VisitationActivityForTrendsFromJson(json);
  Map<String, dynamic> toJson() => _$VisitationActivityForTrendsToJson(this);
}

@JsonSerializable()
class PrayerActivityForTrends {
  String id;
  DateTime datetime;

  PrayerActivityForTrends({
    required this.id,
    required this.datetime,
  });

  factory PrayerActivityForTrends.fromJson(Map<String, dynamic> json) =>
      _$PrayerActivityForTrendsFromJson(json);
  Map<String, dynamic> toJson() => _$PrayerActivityForTrendsToJson(this);
}

@JsonSerializable()
class TelepastoringActivityForTrends {
  String id;
  DateTime datetime;

  TelepastoringActivityForTrends({
    required this.id,
    required this.datetime,
  });

  factory TelepastoringActivityForTrends.fromJson(Map<String, dynamic> json) =>
      _$TelepastoringActivityForTrendsFromJson(json);
  Map<String, dynamic> toJson() => _$TelepastoringActivityForTrendsToJson(this);
}

@JsonSerializable()
class PastoralCycleForTrends extends PastoralCycle {
  @override
  final String id;
  @override
  final String typename;
  @override
  final String startDate;
  @override
  final String endDate;
  @override
  final int numberOfDays;
  final List<VisitationActivityForTrends> visitationsByChurch;

  PastoralCycleForTrends({
    required this.id,
    required this.typename,
    required this.startDate,
    required this.endDate,
    required this.numberOfDays,
    required this.visitationsByChurch,
  }) : super(
          id: id,
          typename: typename,
          startDate: startDate,
          endDate: endDate,
          numberOfDays: numberOfDays,
        );

  factory PastoralCycleForTrends.fromJson(Map<String, dynamic> json) =>
      _$PastoralCycleForTrendsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PastoralCycleForTrendsToJson(this);
}

@JsonSerializable()
class ChurchForPastoralWorkTrends extends Church {
  List<PastoralCycleForTrends> pastoralCycles;

  ChurchForPastoralWorkTrends({
    required this.pastoralCycles,
  });

  factory ChurchForPastoralWorkTrends.fromJson(Map<String, dynamic> json) =>
      _$ChurchForPastoralWorkTrendsFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ChurchForPastoralWorkTrendsToJson(this);
}
