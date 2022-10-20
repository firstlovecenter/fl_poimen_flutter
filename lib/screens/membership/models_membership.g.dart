// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models_membership.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Church _$ChurchFromJson(Map<String, dynamic> json) {
  return Church(
    id: json['id'] as String,
    typename: json['typename'] as String,
    name: json['name'] as String,
    leader: json['leader'] == null
        ? null
        : MemberForList.fromJson(json['leader'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ChurchToJson(Church instance) => <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'name': instance.name,
      'leader': instance.leader,
    };

MemberForList _$MemberForListFromJson(Map<String, dynamic> json) {
  return MemberForList(
    id: json['id'] as String,
    typename: json['typename'] as String,
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    pictureUrl: json['pictureUrl'] as String,
    status: json['status'] as String?,
    phoneNumber: json['phoneNumber'] as String?,
    whatsappNumber: json['whatsappNumber'] as String?,
  );
}

Map<String, dynamic> _$MemberForListToJson(MemberForList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'status': instance.status,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'pictureUrl': instance.pictureUrl,
      'phoneNumber': instance.phoneNumber,
      'whatsappNumber': instance.whatsappNumber,
    };

Member _$MemberFromJson(Map<String, dynamic> json) {
  return Member(
    gender: Gender.fromJson(json['gender'] as Map<String, dynamic>),
    dob: TimeGraph.fromJson(json['dob'] as Map<String, dynamic>),
    stream: Church.fromJson(json['stream'] as Map<String, dynamic>),
    ministry: json['ministry'] == null
        ? null
        : Church.fromJson(json['ministry'] as Map<String, dynamic>),
    fellowship: Church.fromJson(json['fellowship'] as Map<String, dynamic>),
  )
    ..id = json['id'] as String
    ..typename = json['typename'] as String
    ..status = json['status'] as String?
    ..firstName = json['firstName'] as String
    ..lastName = json['lastName'] as String
    ..pictureUrl = json['pictureUrl'] as String
    ..phoneNumber = json['phoneNumber'] as String?
    ..whatsappNumber = json['whatsappNumber'] as String?
    ..lastFourServices = (json['lastFourServices'] as List<dynamic>)
        .map((e) => e as bool)
        .toList();
}

Map<String, dynamic> _$MemberToJson(Member instance) => <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'status': instance.status,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'pictureUrl': instance.pictureUrl,
      'phoneNumber': instance.phoneNumber,
      'whatsappNumber': instance.whatsappNumber,
      'lastFourServices': instance.lastFourServices,
      'gender': instance.gender,
      'dob': instance.dob,
      'stream': instance.stream,
      'fellowship': instance.fellowship,
      'ministry': instance.ministry,
    };

Node _$NodeFromJson(Map<String, dynamic> json) {
  return Node(
    node: MemberForList.fromJson(json['node'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$NodeToJson(Node instance) => <String, dynamic>{
      'node': instance.node,
    };

PaginatedMemberList _$PaginatedMemberListFromJson(Map<String, dynamic> json) {
  return PaginatedMemberList(
    edges: (json['edges'] as List<dynamic>)
        .map((e) => Node.fromJson(e as Map<String, dynamic>))
        .toList(),
    totalCount: json['totalCount'] as int,
    position: json['position'] as int,
  );
}

Map<String, dynamic> _$PaginatedMemberListToJson(
        PaginatedMemberList instance) =>
    <String, dynamic>{
      'edges': instance.edges,
      'totalCount': instance.totalCount,
      'position': instance.position,
    };

ChurchForMemberList _$ChurchForMemberListFromJson(Map<String, dynamic> json) {
  return ChurchForMemberList(
    sheepPaginated: PaginatedMemberList.fromJson(
        json['sheepPaginated'] as Map<String, dynamic>),
    goatsPaginated: PaginatedMemberList.fromJson(
        json['goatsPaginated'] as Map<String, dynamic>),
    deerPaginated: PaginatedMemberList.fromJson(
        json['deerPaginated'] as Map<String, dynamic>),
  )
    ..id = json['id'] as String
    ..typename = json['typename'] as String
    ..name = json['name'] as String
    ..leader = json['leader'] == null
        ? null
        : MemberForList.fromJson(json['leader'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ChurchForMemberListToJson(
        ChurchForMemberList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'name': instance.name,
      'leader': instance.leader,
      'sheepPaginated': instance.sheepPaginated,
      'goatsPaginated': instance.goatsPaginated,
      'deerPaginated': instance.deerPaginated,
    };
