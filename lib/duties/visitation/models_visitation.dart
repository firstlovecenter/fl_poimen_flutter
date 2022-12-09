import 'package:json_annotation/json_annotation.dart';
import 'package:poimen/duties/imcl/models_imcl.dart';
import 'package:poimen/screens/membership/models_membership.dart';

part 'models_visitation.g.dart';

@JsonSerializable()
class OutstandingVisitationForList extends MemberForList {
  OutstandingVisitationForList({
    required String id,
    required String typename,
    required String firstName,
    required String lastName,
    required String pictureUrl,
    String? status,
    String? phoneNumber,
    String? whatsappNumber,
  }) : super(
          id: id,
          typename: typename,
          firstName: firstName,
          lastName: lastName,
          pictureUrl: pictureUrl,
          status: status,
          phoneNumber: phoneNumber,
          whatsappNumber: whatsappNumber,
        );

  factory OutstandingVisitationForList.fromJson(Map<String, dynamic> json) =>
      _$OutstandingVisitationForListFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$OutstandingVisitationForListToJson(this);
}

@JsonSerializable()
class ChurchForOutstandingVisitationList extends Church {
  List<OutstandingVisitationForList> outstandingVisitations = [];

  ChurchForOutstandingVisitationList({
    required this.outstandingVisitations,
  });

  factory ChurchForOutstandingVisitationList.fromJson(Map<String, dynamic> json) =>
      _$ChurchForOutstandingVisitationListFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ChurchForOutstandingVisitationListToJson(this);
}
