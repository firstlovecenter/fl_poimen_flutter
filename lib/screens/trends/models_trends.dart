import 'package:json_annotation/json_annotation.dart';
import 'package:poimen/screens/home/models_home_screen.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/models/neo4j.dart';
part 'models_trends.g.dart';

@JsonSerializable()
class ChurchForTrendsMenu extends Church {
  PastoralCycle currentPastoralCycle;
  @override
  // ignore: overridden_fields
  final MemberForList leader;

  ChurchForTrendsMenu({
    required this.currentPastoralCycle,
    required this.leader,
  });

  factory ChurchForTrendsMenu.fromJson(Map<String, dynamic> json) =>
      _$ChurchForTrendsMenuFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ChurchForTrendsMenuToJson(this);
}

@JsonSerializable()
class ServicesForTrends {
  String id = '';
  String typename = '';
  TimeGraph serviceDate = TimeGraph();
  int attendance = 0;
  int membersPresentFromFellowshipCount = 0;
  int membersAbsentFromFellowshipCount = 0;

  ServicesForTrends({
    required this.id,
    required this.serviceDate,
    required this.attendance,
    required this.membersPresentFromFellowshipCount,
    required this.membersAbsentFromFellowshipCount,
  });

  factory ServicesForTrends.fromJson(Map<String, dynamic> json) =>
      _$ServicesForTrendsFromJson(json);
  Map<String, dynamic> toJson() => _$ServicesForTrendsToJson(this);
}

@JsonSerializable()
class ChurchForMembershipAttendanceTrends extends Church {
  List<ServicesForTrends> services = [];
  List<ServicesForTrends> bussing = [];

  ChurchForMembershipAttendanceTrends({
    required this.services,
    required this.bussing,
  });

  factory ChurchForMembershipAttendanceTrends.fromJson(Map<String, dynamic> json) =>
      _$ChurchForMembershipAttendanceTrendsFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ChurchForMembershipAttendanceTrendsToJson(this);
}
