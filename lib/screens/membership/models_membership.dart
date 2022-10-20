// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';
import 'package:poimen/models/neo4j.dart';
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
  String typename = 'Member';
  String? status = '';
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
          status: '',
          firstName: '',
          lastName: '',
          pictureUrl: '',
        );

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$MemberToJson(this);
}

@JsonSerializable()
class Node {
  MemberForList node = MemberForList(
    id: '',
    typename: '',
    firstName: '',
    lastName: '',
    pictureUrl: '',
  );

  Node({required this.node});

  factory Node.fromJson(Map<String, dynamic> json) => _$NodeFromJson(json);
  Map<String, dynamic> toJson() => _$NodeToJson(this);
}

@JsonSerializable()
class PaginatedMemberList {
  List<Node> edges = [];
  int totalCount = 0;
  int position = 0;

  PaginatedMemberList({
    required this.edges,
    required this.totalCount,
    required this.position,
  });

  factory PaginatedMemberList.fromJson(Map<String, dynamic> json) =>
      _$PaginatedMemberListFromJson(json);
  Map<String, dynamic> toJson() => _$PaginatedMemberListToJson(this);
}

@JsonSerializable()
class ChurchForMemberList extends Church {
  PaginatedMemberList sheepPaginated = PaginatedMemberList(
    edges: [],
    totalCount: 0,
    position: 0,
  );
  PaginatedMemberList goatsPaginated = PaginatedMemberList(
    edges: [],
    totalCount: 0,
    position: 0,
  );
  PaginatedMemberList deerPaginated = PaginatedMemberList(
    edges: [],
    totalCount: 0,
    position: 0,
  );

  ChurchForMemberList(
      {required this.sheepPaginated, required this.goatsPaginated, required this.deerPaginated})
      : super(id: '', typename: '', name: '');

  factory ChurchForMemberList.fromJson(Map<String, dynamic> json) =>
      _$ChurchForMemberListFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ChurchForMemberListToJson(this);
}
