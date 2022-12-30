import 'package:json_annotation/json_annotation.dart';
import 'package:poimen/screens/membership/models_membership.dart';

part 'models_telepastoring.g.dart';

@JsonSerializable()
class OutstandingTelepastoringForList extends MemberForList {
  OutstandingTelepastoringForList({
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

  factory OutstandingTelepastoringForList.fromJson(Map<String, dynamic> json) =>
      _$OutstandingTelepastoringForListFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$OutstandingTelepastoringForListToJson(this);
}

@JsonSerializable()
class CompletedTelepastoringForList extends MemberForList {
  CompletedTelepastoringForList({
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

  factory CompletedTelepastoringForList.fromJson(Map<String, dynamic> json) =>
      _$CompletedTelepastoringForListFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$CompletedTelepastoringForListToJson(this);
}

@JsonSerializable()
class ChurchForOutstandingTelepastoringList extends Church {
  int completedTelepastoringCount = 0;
  List<OutstandingTelepastoringForList> outstandingTelepastoring = [];

  ChurchForOutstandingTelepastoringList({
    required this.outstandingTelepastoring,
    required this.completedTelepastoringCount,
  });

  factory ChurchForOutstandingTelepastoringList.fromJson(Map<String, dynamic> json) =>
      _$ChurchForOutstandingTelepastoringListFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ChurchForOutstandingTelepastoringListToJson(this);
}

@JsonSerializable()
class ChurchForCompletedTelepastoringList extends Church {
  int outstandingTelepastoringCount = 0;
  List<CompletedTelepastoringForList> completedTelepastoring = [];

  ChurchForCompletedTelepastoringList({
    required this.completedTelepastoring,
    required this.outstandingTelepastoringCount,
  });

  factory ChurchForCompletedTelepastoringList.fromJson(Map<String, dynamic> json) =>
      _$ChurchForCompletedTelepastoringListFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ChurchForCompletedTelepastoringListToJson(this);
}
