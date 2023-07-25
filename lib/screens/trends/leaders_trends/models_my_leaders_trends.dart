import 'package:json_annotation/json_annotation.dart';
import 'package:poimen/screens/membership/models_membership.dart';
part 'models_my_leaders_trends.g.dart';

@JsonSerializable()
class ChurchWithSubChurchList extends Church {
  @override
  List<Church> subChurches = [];

  ChurchWithSubChurchList({
    required this.subChurches,
  });

  factory ChurchWithSubChurchList.fromJson(Map<String, dynamic> json) =>
      _$ChurchWithSubChurchListFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ChurchWithSubChurchListToJson(this);
}
