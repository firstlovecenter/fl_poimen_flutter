import 'package:json_annotation/json_annotation.dart';
import 'package:poimen/screens/duties/imcl/models_imcl.dart';
import 'package:poimen/screens/home/models_home_screen.dart';
import 'package:poimen/screens/membership/models_membership.dart';
part 'models_pastoral_work_trends.g.dart';

@JsonSerializable()
class VisitationActivity {
  String id;
  String typename;
  DateTime datetime;
  String location;
  String picture;
  PastoralComments comment;
  MemberForList memberVisited;
  PastoralCycle pastoralCycle;

  VisitationActivity({
    required this.id,
    required this.typename,
    required this.datetime,
    required this.location,
    required this.picture,
    required this.comment,
    required this.memberVisited,
    required this.pastoralCycle,
  });

  factory VisitationActivity.fromJson(Map<String, dynamic> json) =>
      _$VisitationActivityFromJson(json);
  Map<String, dynamic> toJson() => _$VisitationActivityToJson(this);
}

@JsonSerializable()
class PrayerActivity {
  String id;
  DateTime datetime;
  PastoralComments comment;
  MemberForList memberPrayedFor;
  PastoralCycle pastoralCycle;

  PrayerActivity({
    required this.id,
    required this.datetime,
    required this.comment,
    required this.memberPrayedFor,
    required this.pastoralCycle,
  });

  factory PrayerActivity.fromJson(Map<String, dynamic> json) => _$PrayerActivityFromJson(json);
  Map<String, dynamic> toJson() => _$PrayerActivityToJson(this);
}

@JsonSerializable()
class TelepastoringActivity {
  String id;
  DateTime datetime;
  PastoralComments comment;
  MemberForList memberTelepastored;
  PastoralCycle pastoralCycle;

  TelepastoringActivity({
    required this.id,
    required this.datetime,
    required this.comment,
    required this.memberTelepastored,
    required this.pastoralCycle,
  });

  factory TelepastoringActivity.fromJson(Map<String, dynamic> json) =>
      _$TelepastoringActivityFromJson(json);
  Map<String, dynamic> toJson() => _$TelepastoringActivityToJson(this);
}

@JsonSerializable()
class PastoralCycleForTrends extends PastoralCycle {
  VisitationActivity visitationsByChurch;
  PrayerActivity prayersByChurch;
  TelepastoringActivity telepastoringsByChurch;

  PastoralCycleForTrends({
    required this.visitationsByChurch,
    required this.prayersByChurch,
    required this.telepastoringsByChurch,
  }) : super(
          id: '',
          typename: '',
          startDate: '',
          endDate: '',
          numberOfDays: 0,
        );

  factory PastoralCycleForTrends.fromJson(Map<String, dynamic> json) =>
      _$PastoralCycleForTrendsFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$PastoralCycleForTrendsToJson(this);
}

@JsonSerializable()
class ChurchForPastoralWorkTrends extends Church {
  PastoralCycleForTrends pastoralCycles;

  ChurchForPastoralWorkTrends({
    required this.pastoralCycles,
  });

  factory ChurchForPastoralWorkTrends.fromJson(Map<String, dynamic> json) =>
      _$ChurchForPastoralWorkTrendsFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ChurchForPastoralWorkTrendsToJson(this);
}
