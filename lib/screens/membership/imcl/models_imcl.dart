import 'package:json_annotation/json_annotation.dart';
import 'package:poimen/screens/membership/models_membership.dart';
part 'models_imcl.g.dart';

@JsonSerializable()
class ChurchForImclList extends Church {
  List<MemberForList> imcls = [];

  ChurchForImclList({
    required this.imcls,
  }) : super(id: '', typename: '', name: '');

  factory ChurchForImclList.fromJson(Map<String, dynamic> json) =>
      _$ChurchForImclListFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ChurchForImclListToJson(this);
}
