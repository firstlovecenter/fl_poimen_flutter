import 'package:json_annotation/json_annotation.dart';
import 'package:poimen/screens/membership/models_membership.dart';
part 'models_search.g.dart';

@JsonSerializable()
class ChurchForSearchList extends Church {
  List<MemberForList> memberSearch = [];

  ChurchForSearchList({
    required this.memberSearch,
  });

  factory ChurchForSearchList.fromJson(Map<String, dynamic> json) =>
      _$ChurchForSearchListFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ChurchForSearchListToJson(this);
}
