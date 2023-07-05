import 'package:json_annotation/json_annotation.dart';
import 'package:poimen/screens/home/models_home_screen.dart';
import 'package:poimen/screens/membership/models_membership.dart';
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
