// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';
import 'package:poimen/models/global.dart';
import 'package:poimen/state/enums.dart';
part 'models_membership.g.dart';

@JsonSerializable()
class Church {
  String id = '';
  String typename = '';
  String name = '';
  Member leader;

  Church({
    required this.id,
    required this.typename,
    required this.name,
    required this.leader,
  });

  factory Church.fromJson(Map<String, dynamic> json) => _$ChurchFromJson(json);
  Map<String, dynamic> toJson() => _$ChurchToJson(this);
}

@JsonSerializable()
class Member {
  String id = '';
  String typename = 'Member';
  String firstName = '';
  String lastName = '';
  String pictureUrl = '';
  List<bool> lastFourServices = [];
  Map<String, String> gender = {'gender': ''};
  Map<String, String> dob = {'date': ''};
  String phoneNumber = '';
  String whatsappNumber = '';
  ChurchLevel stream_name = ChurchLevel.fellowship;
  Church fellowship;
  Church? ministry;

  Member(
      {required this.id,
      required this.typename,
      required this.firstName,
      required this.lastName,
      required this.pictureUrl,
      required this.gender,
      required this.dob,
      required this.phoneNumber,
      required this.whatsappNumber,
      required this.stream_name,
      required this.ministry,
      required this.fellowship});

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
