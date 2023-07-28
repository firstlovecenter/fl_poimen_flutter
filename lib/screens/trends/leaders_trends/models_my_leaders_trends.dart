import 'package:json_annotation/json_annotation.dart';
import 'package:poimen/screens/membership/models_membership.dart';
part 'models_my_leaders_trends.g.dart';

@JsonSerializable()
class MembershipData {
  String id;
  String typename;
  int sheepCount;
  int deerCount;
  int goatsCount;
  int membersCount;

  MembershipData({
    required this.id,
    required this.typename,
    required this.sheepCount,
    required this.deerCount,
    required this.goatsCount,
    required this.membersCount,
  });

  factory MembershipData.fromJson(Map<String, dynamic> json) => _$MembershipDataFromJson(json);
  Map<String, dynamic> toJson() => _$MembershipDataToJson(this);
}

@JsonSerializable()
class ChurchForOverallCycleAssessment extends Church {
  int memberCount;
  int completedVisitationsCount;
  int completedTelepastoringCount;
  int completedPrayersCount;

  ChurchForOverallCycleAssessment({
    required this.memberCount,
    required this.completedVisitationsCount,
    required this.completedPrayersCount,
    required this.completedTelepastoringCount,
  });

  factory ChurchForOverallCycleAssessment.fromJson(Map<String, dynamic> json) =>
      _$ChurchForOverallCycleAssessmentFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ChurchForOverallCycleAssessmentToJson(this);
}

@JsonSerializable()
class ChurchWithSubChurchList extends Church {
  List<ChurchForOverallCycleAssessment> subChurches = [];

  ChurchWithSubChurchList({
    required this.subChurches,
  });

  factory ChurchWithSubChurchList.fromJson(Map<String, dynamic> json) =>
      _$ChurchWithSubChurchListFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ChurchWithSubChurchListToJson(this);
}

@JsonSerializable()
class CampusWithSubChurchList extends Church {
  List<Church> subChurches = [];

  CampusWithSubChurchList({
    required this.subChurches,
  });

  factory CampusWithSubChurchList.fromJson(Map<String, dynamic> json) =>
      _$CampusWithSubChurchListFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$CampusWithSubChurchListToJson(this);
}
