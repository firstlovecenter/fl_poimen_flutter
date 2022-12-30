import 'package:json_annotation/json_annotation.dart';
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
class CompletedVisitationForList extends MemberForList {
  CompletedVisitationForList({
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

  factory CompletedVisitationForList.fromJson(Map<String, dynamic> json) =>
      _$CompletedVisitationForListFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$CompletedVisitationForListToJson(this);
}

@JsonSerializable()
class ChurchForOutstandingVisitationList extends Church {
  int completedVisitationsCount = 0;
  List<OutstandingVisitationForList> outstandingVisitations = [];

  ChurchForOutstandingVisitationList({
    required this.outstandingVisitations,
    required this.completedVisitationsCount,
  });

  factory ChurchForOutstandingVisitationList.fromJson(Map<String, dynamic> json) =>
      _$ChurchForOutstandingVisitationListFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ChurchForOutstandingVisitationListToJson(this);
}

@JsonSerializable()
class ChurchForCompletedVisitationList extends Church {
  int outstandingVisitationsCount = 0;
  List<CompletedVisitationForList> completedVisitations = [];

  ChurchForCompletedVisitationList({
    required this.completedVisitations,
    required this.outstandingVisitationsCount,
  });

  factory ChurchForCompletedVisitationList.fromJson(Map<String, dynamic> json) =>
      _$ChurchForCompletedVisitationListFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ChurchForCompletedVisitationListToJson(this);
}
