import 'package:json_annotation/json_annotation.dart';
import 'package:poimen/screens/membership/models_membership.dart';
part 'models_imcl.g.dart';

@JsonSerializable()
class ImclForList extends MemberForList {
  bool imclChecked = false;
  List<MissedChurchComment> missedChurchComments = [];

  ImclForList({
    required String id,
    required String typename,
    required String firstName,
    required String lastName,
    required String pictureUrl,
    String? status,
    String? phoneNumber,
    String? whatsappNumber,
    required this.imclChecked,
    required this.missedChurchComments,
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

  factory ImclForList.fromJson(Map<String, dynamic> json) => _$ImclForListFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ImclForListToJson(this);
}

@JsonSerializable()
class ChurchForImclList extends Church {
  List<ImclForList> imcls = [];

  ChurchForImclList({
    required this.imcls,
  }) : super(id: '', typename: '', name: '');

  factory ChurchForImclList.fromJson(Map<String, dynamic> json) =>
      _$ChurchForImclListFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ChurchForImclListToJson(this);
}

@JsonSerializable()
class PastoralComments {
  String id = '';
  String typename = '';
  DateTime timestamp = DateTime.now();
  String comment = '';
  MemberForList author = MemberForList(
    id: '',
    typename: '',
    firstName: '',
    lastName: '',
    pictureUrl: '',
  );

  PastoralComments({
    required this.id,
    required this.typename,
    required this.timestamp,
    required this.comment,
    required this.author,
  });

  factory PastoralComments.fromJson(Map<String, dynamic> json) => _$PastoralCommentsFromJson(json);
  Map<String, dynamic> toJson() => _$PastoralCommentsToJson(this);
}

@JsonSerializable()
class MissedChurchComment extends PastoralComments {
  MissedChurchComment()
      : super(
          id: '',
          typename: '',
          timestamp: DateTime.now(),
          comment: '',
          author: MemberForList(
            id: '',
            typename: '',
            firstName: '',
            lastName: '',
            pictureUrl: '',
          ),
        );

  factory MissedChurchComment.fromJson(Map<String, dynamic> json) =>
      _$MissedChurchCommentFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$MissedChurchCommentToJson(this);
}
