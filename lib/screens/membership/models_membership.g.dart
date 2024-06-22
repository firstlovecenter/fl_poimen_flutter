// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models_membership.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Church _$ChurchFromJson(Map<String, dynamic> json) => Church(
      leader: json['leader'] == null
          ? null
          : MemberForList.fromJson(json['leader'] as Map<String, dynamic>),
    )
      ..id = json['id'] as String
      ..typename = json['typename'] as String
      ..name = json['name'] as String
      ..admin = json['admin'] == null
          ? null
          : MemberForList.fromJson(json['admin'] as Map<String, dynamic>);

Map<String, dynamic> _$ChurchToJson(Church instance) => <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'name': instance.name,
      'leader': instance.leader,
      'admin': instance.admin,
    };

MemberForList _$MemberForListFromJson(Map<String, dynamic> json) =>
    MemberForList(
      id: json['id'] as String,
      typename: json['typename'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      pictureUrl: json['pictureUrl'] as String,
      phoneNumber: json['phoneNumber'] as String,
      whatsappNumber: json['whatsappNumber'] as String,
      status: json['status'] as String?,
    )..lost = json['lost'] as bool?;

Map<String, dynamic> _$MemberForListToJson(MemberForList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'status': instance.status,
      'lost': instance.lost,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'pictureUrl': instance.pictureUrl,
      'phoneNumber': instance.phoneNumber,
      'whatsappNumber': instance.whatsappNumber,
    };

MemberWithComments _$MemberWithCommentsFromJson(Map<String, dynamic> json) =>
    MemberWithComments(
      pastoralComments: (json['pastoralComments'] as List<dynamic>?)
          ?.map((e) => PastoralComments.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..id = json['id'] as String
      ..typename = json['typename'] as String
      ..status = json['status'] as String?
      ..lost = json['lost'] as bool?
      ..firstName = json['firstName'] as String
      ..lastName = json['lastName'] as String
      ..pictureUrl = json['pictureUrl'] as String
      ..phoneNumber = json['phoneNumber'] as String
      ..whatsappNumber = json['whatsappNumber'] as String;

Map<String, dynamic> _$MemberWithCommentsToJson(MemberWithComments instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'status': instance.status,
      'lost': instance.lost,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'pictureUrl': instance.pictureUrl,
      'phoneNumber': instance.phoneNumber,
      'whatsappNumber': instance.whatsappNumber,
      'pastoralComments': instance.pastoralComments,
    };

Last4Services _$Last4ServicesFromJson(Map<String, dynamic> json) =>
    Last4Services(
      date: DateTime.parse(json['date'] as String),
      service: json['service'] as String,
      present: json['present'] as bool,
    );

Map<String, dynamic> _$Last4ServicesToJson(Last4Services instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'service': instance.service,
      'present': instance.present,
    };

Member _$MemberFromJson(Map<String, dynamic> json) => Member(
      gender: Gender.fromJson(json['gender'] as Map<String, dynamic>),
      dob: TimeGraph.fromJson(json['dob'] as Map<String, dynamic>),
      council: Church.fromJson(json['council'] as Map<String, dynamic>),
      ministry: json['ministry'] == null
          ? null
          : Church.fromJson(json['ministry'] as Map<String, dynamic>),
      bacenta: Church.fromJson(json['bacenta'] as Map<String, dynamic>),
      stickyNote: json['stickyNote'] as String?,
      pastoralComments: (json['pastoralComments'] as List<dynamic>?)
          ?.map((e) => PastoralComments.fromJson(e as Map<String, dynamic>))
          .toList(),
      occupation: json['occupation'] == null
          ? null
          : Occupation.fromJson(json['occupation'] as Map<String, dynamic>),
      maritalStatus:
          MaritalStatus.fromJson(json['maritalStatus'] as Map<String, dynamic>),
      lastFourWeekdayServices:
          (json['lastFourWeekdayServices'] as List<dynamic>)
              .map((e) => Last4Services.fromJson(e as Map<String, dynamic>))
              .toList(),
      lastFourWeekendServices:
          (json['lastFourWeekendServices'] as List<dynamic>)
              .map((e) => Last4Services.fromJson(e as Map<String, dynamic>))
              .toList(),
      lastAttendedServiceDate: json['lastAttendedServiceDate'] == null
          ? null
          : DateTime.parse(json['lastAttendedServiceDate'] as String),
      location: json['location'] == null
          ? null
          : Neo4jPoint.fromJson(json['location'] as Map<String, dynamic>),
      visitationArea: json['visitationArea'] as String,
      roles: json['roles'] as String,
      nameWithTitle: json['nameWithTitle'] as String,
      currentTitle: json['currentTitle'] as String?,
    )
      ..id = json['id'] as String
      ..typename = json['typename'] as String
      ..status = json['status'] as String?
      ..lost = json['lost'] as bool?
      ..firstName = json['firstName'] as String
      ..lastName = json['lastName'] as String
      ..pictureUrl = json['pictureUrl'] as String
      ..phoneNumber = json['phoneNumber'] as String
      ..whatsappNumber = json['whatsappNumber'] as String
      ..middleName = json['middleName'] as String
      ..email = json['email'] as String?;

Map<String, dynamic> _$MemberToJson(Member instance) => <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'status': instance.status,
      'lost': instance.lost,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'pictureUrl': instance.pictureUrl,
      'phoneNumber': instance.phoneNumber,
      'whatsappNumber': instance.whatsappNumber,
      'middleName': instance.middleName,
      'email': instance.email,
      'currentTitle': instance.currentTitle,
      'nameWithTitle': instance.nameWithTitle,
      'roles': instance.roles,
      'stickyNote': instance.stickyNote,
      'visitationArea': instance.visitationArea,
      'location': instance.location,
      'lastAttendedServiceDate':
          instance.lastAttendedServiceDate?.toIso8601String(),
      'lastFourWeekdayServices': instance.lastFourWeekdayServices,
      'lastFourWeekendServices': instance.lastFourWeekendServices,
      'gender': instance.gender,
      'occupation': instance.occupation,
      'maritalStatus': instance.maritalStatus,
      'dob': instance.dob,
      'council': instance.council,
      'bacenta': instance.bacenta,
      'ministry': instance.ministry,
      'pastoralComments': instance.pastoralComments,
    };

Node _$NodeFromJson(Map<String, dynamic> json) => Node(
      node: MemberForList.fromJson(json['node'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NodeToJson(Node instance) => <String, dynamic>{
      'node': instance.node,
    };

PaginatedMemberList _$PaginatedMemberListFromJson(Map<String, dynamic> json) =>
    PaginatedMemberList(
      edges: (json['edges'] as List<dynamic>)
          .map((e) => Node.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: (json['totalCount'] as num).toInt(),
      position: (json['position'] as num).toInt(),
    );

Map<String, dynamic> _$PaginatedMemberListToJson(
        PaginatedMemberList instance) =>
    <String, dynamic>{
      'edges': instance.edges,
      'totalCount': instance.totalCount,
      'position': instance.position,
    };

ChurchForPaginatedMemberList _$ChurchForPaginatedMemberListFromJson(
        Map<String, dynamic> json) =>
    ChurchForPaginatedMemberList(
      sheepPaginated: json['sheepPaginated'] == null
          ? null
          : PaginatedMemberList.fromJson(
              json['sheepPaginated'] as Map<String, dynamic>),
      goatsPaginated: json['goatsPaginated'] == null
          ? null
          : PaginatedMemberList.fromJson(
              json['goatsPaginated'] as Map<String, dynamic>),
      deerPaginated: json['deerPaginated'] == null
          ? null
          : PaginatedMemberList.fromJson(
              json['deerPaginated'] as Map<String, dynamic>),
    )
      ..id = json['id'] as String
      ..typename = json['typename'] as String
      ..name = json['name'] as String
      ..leader = json['leader'] == null
          ? null
          : MemberForList.fromJson(json['leader'] as Map<String, dynamic>)
      ..admin = json['admin'] == null
          ? null
          : MemberForList.fromJson(json['admin'] as Map<String, dynamic>);

Map<String, dynamic> _$ChurchForPaginatedMemberListToJson(
        ChurchForPaginatedMemberList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'name': instance.name,
      'leader': instance.leader,
      'admin': instance.admin,
      'sheepPaginated': instance.sheepPaginated,
      'goatsPaginated': instance.goatsPaginated,
      'deerPaginated': instance.deerPaginated,
    };

PaginatedMemberCounts _$PaginatedMemberCountsFromJson(
        Map<String, dynamic> json) =>
    PaginatedMemberCounts(
      totalCount: (json['totalCount'] as num).toInt(),
    );

Map<String, dynamic> _$PaginatedMemberCountsToJson(
        PaginatedMemberCounts instance) =>
    <String, dynamic>{
      'totalCount': instance.totalCount,
    };

ChurchForPaginatedMemberCounts _$ChurchForPaginatedMemberCountsFromJson(
        Map<String, dynamic> json) =>
    ChurchForPaginatedMemberCounts(
      sheepPaginated: json['sheepPaginated'] == null
          ? null
          : PaginatedMemberCounts.fromJson(
              json['sheepPaginated'] as Map<String, dynamic>),
      goatsPaginated: json['goatsPaginated'] == null
          ? null
          : PaginatedMemberCounts.fromJson(
              json['goatsPaginated'] as Map<String, dynamic>),
      deerPaginated: json['deerPaginated'] == null
          ? null
          : PaginatedMemberCounts.fromJson(
              json['deerPaginated'] as Map<String, dynamic>),
    )
      ..id = json['id'] as String
      ..typename = json['typename'] as String
      ..name = json['name'] as String
      ..leader = json['leader'] == null
          ? null
          : MemberForList.fromJson(json['leader'] as Map<String, dynamic>)
      ..admin = json['admin'] == null
          ? null
          : MemberForList.fromJson(json['admin'] as Map<String, dynamic>);

Map<String, dynamic> _$ChurchForPaginatedMemberCountsToJson(
        ChurchForPaginatedMemberCounts instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'name': instance.name,
      'leader': instance.leader,
      'admin': instance.admin,
      'sheepPaginated': instance.sheepPaginated,
      'goatsPaginated': instance.goatsPaginated,
      'deerPaginated': instance.deerPaginated,
    };

ChurchForMemberListByCategory _$ChurchForMemberListByCategoryFromJson(
        Map<String, dynamic> json) =>
    ChurchForMemberListByCategory(
      sheep: (json['sheep'] as List<dynamic>)
          .map((e) => MemberForList.fromJson(e as Map<String, dynamic>))
          .toList(),
      goats: (json['goats'] as List<dynamic>)
          .map((e) => MemberForList.fromJson(e as Map<String, dynamic>))
          .toList(),
      deer: (json['deer'] as List<dynamic>)
          .map((e) => MemberForList.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..id = json['id'] as String
      ..typename = json['typename'] as String
      ..name = json['name'] as String
      ..leader = json['leader'] == null
          ? null
          : MemberForList.fromJson(json['leader'] as Map<String, dynamic>)
      ..admin = json['admin'] == null
          ? null
          : MemberForList.fromJson(json['admin'] as Map<String, dynamic>);

Map<String, dynamic> _$ChurchForMemberListByCategoryToJson(
        ChurchForMemberListByCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'name': instance.name,
      'leader': instance.leader,
      'admin': instance.admin,
      'sheep': instance.sheep,
      'goats': instance.goats,
      'deer': instance.deer,
    };
