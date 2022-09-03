import 'package:json_annotation/json_annotation.dart';
part 'models_membership.g.dart';

@JsonSerializable()
class Member {
  String id = '';
  String typename = 'Member';
  String firstName = '';
  String lastName = '';
  String fullName = '';
  String pictureUrl = '';
  Map<String, String> gender = {'gender': ''};
  Map<String, String> dob = {'date': ''};
  String phoneNumber = '';

  Member(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.fullName,
      required this.pictureUrl,
      required this.gender,
      required this.dob,
      required this.phoneNumber});

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);
  Map<String, dynamic> toJson() => _$MemberToJson(this);
}

@JsonSerializable()
class ChurchForMemberList {
  String id = '';
  String typename = 'Fellowship';
  String name = '';
  List<Member> sheep = [];
  List<Member> goats = [];
  List<Member> deer = [];

  ChurchForMemberList(
      {required this.id,
      required this.name,
      required this.sheep,
      required this.goats,
      required this.deer});

  factory ChurchForMemberList.fromJson(Map<String, dynamic> json) =>
      _$ChurchForMemberListFromJson(json);
  Map<String, dynamic> toJson() => _$ChurchForMemberListToJson(this);
}
