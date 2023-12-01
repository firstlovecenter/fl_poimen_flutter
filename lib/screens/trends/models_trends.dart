import 'package:json_annotation/json_annotation.dart';
import 'package:poimen/screens/home/models_home_screen.dart';
import 'package:poimen/screens/membership/models_membership.dart';
part 'models_trends.g.dart';

@JsonSerializable()
class ChurchForTrendsMenu extends Church {
  PastoralCycle? currentPastoralCycle;
  @override
  // ignore: overridden_fields
  final MemberForList leader;

  ChurchForTrendsMenu({
    this.currentPastoralCycle,
    required this.leader,
  });

  factory ChurchForTrendsMenu.fromJson(Map<String, dynamic> json) =>
      _$ChurchForTrendsMenuFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ChurchForTrendsMenuToJson(this);
}

@JsonSerializable()
class ServiceWeeksForTrends {
  int week = 0;
  String typename = '';
  int attendance = 0;
  int membersPresentAtWeekdayCount = 0;
  int membersAbsentAtWeekdayCount = 0;

  ServiceWeeksForTrends({
    required this.week,
    required this.typename,
    required this.attendance,
    required this.membersPresentAtWeekdayCount,
    required this.membersAbsentAtWeekdayCount,
  });

  factory ServiceWeeksForTrends.fromJson(Map<String, dynamic> json) =>
      _$ServiceWeeksForTrendsFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceWeeksForTrendsToJson(this);
}

@JsonSerializable()
class BussingWeeksForTrends {
  int week = 0;
  String typename = '';
  int attendance = 0;
  int membersPresentAtWeekendCount = 0;
  int membersAbsentAtWeekendCount = 0;

  BussingWeeksForTrends({
    required this.week,
    required this.typename,
    required this.attendance,
    required this.membersPresentAtWeekendCount,
    required this.membersAbsentAtWeekendCount,
  });

  factory BussingWeeksForTrends.fromJson(Map<String, dynamic> json) =>
      _$BussingWeeksForTrendsFromJson(json);
  Map<String, dynamic> toJson() => _$BussingWeeksForTrendsToJson(this);
}

@JsonSerializable()
class ChurchForMembershipAttendanceTrends extends Church {
  int sheepCount = 0;
  int goatsCount = 0;
  int deerCount = 0;
  int lostCount = 0;
  List<ServiceWeeksForTrends> serviceWeeks = [];
  List<BussingWeeksForTrends> bussingWeeks = [];
  @override
  // ignore: overridden_fields
  final MemberForList leader;

  ChurchForMembershipAttendanceTrends({
    required this.sheepCount,
    required this.goatsCount,
    required this.deerCount,
    required this.lostCount,
    required this.serviceWeeks,
    required this.bussingWeeks,
    required this.leader,
  });

  factory ChurchForMembershipAttendanceTrends.fromJson(Map<String, dynamic> json) =>
      _$ChurchForMembershipAttendanceTrendsFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ChurchForMembershipAttendanceTrendsToJson(this);
}
