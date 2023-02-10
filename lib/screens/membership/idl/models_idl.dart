import 'package:json_annotation/json_annotation.dart';
import 'package:poimen/screens/duties/visitation/models_visitation.dart';
import 'package:poimen/screens/membership/models_membership.dart';
part 'models_idl.g.dart';

@JsonSerializable()
class ChurchForIdlList extends Church {
  List<OutstandingVisitationForList> idls = [];

  ChurchForIdlList({
    required this.idls,
  });

  factory ChurchForIdlList.fromJson(Map<String, dynamic> json) => _$ChurchForIdlListFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ChurchForIdlListToJson(this);
}
