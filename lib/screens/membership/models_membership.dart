// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';
import 'package:poimen/models/neo4j.dart';
import 'package:poimen/state/enums.dart';
part 'models_membership.g.dart';

@JsonSerializable()
class Church {
  String id = '';
  String typename = '';
  String name = '';
  MemberForList? leader;

  Church({
    required this.id,
    required this.typename,
    required this.name,
    this.leader,
  });

  factory Church.fromJson(Map<String, dynamic> json) => _$ChurchFromJson(json);
  Map<String, dynamic> toJson() => _$ChurchToJson(this);
}

@JsonSerializable()
class MemberForList {
  String id = '';
  MemberCategory? status = MemberCategory.Sheep;
  String typename = 'Member';
  String firstName = '';
  String lastName = '';
  String pictureUrl = '';
  String? phoneNumber;
  String? whatsappNumber;

  MemberForList({
    required this.id,
    required this.typename,
    required this.firstName,
    required this.lastName,
    required this.pictureUrl,
    this.status,
    this.phoneNumber,
    this.whatsappNumber,
  });

  factory MemberForList.fromJson(Map<String, dynamic> json) => _$MemberForListFromJson(json);
  Map<String, dynamic> toJson() => _$MemberForListToJson(this);
}

@JsonSerializable()
class Member extends MemberForList {
  List<bool> lastFourServices = [];
  Gender gender = Gender();
  TimeGraph dob = TimeGraph();
  Church stream;
  Church fellowship;
  Church? ministry;

  Member(
      {required this.gender,
      required this.dob,
      required this.stream,
      required this.ministry,
      required this.fellowship})
      : super(
          id: '',
          typename: '',
          firstName: '',
          lastName: '',
          pictureUrl: '',
        );

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$MemberToJson(this);
}

@JsonSerializable()
class ChurchForMemberList extends Church {
  List<MemberForList> sheep = [];
  List<MemberForList> goats = [];
  List<MemberForList> deer = [];

  ChurchForMemberList({required this.sheep, required this.goats, required this.deer})
      : super(id: '', typename: '', name: '');

  factory ChurchForMemberList.fromJson(Map<String, dynamic> json) =>
      _$ChurchForMemberListFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ChurchForMemberListToJson(this);
}
