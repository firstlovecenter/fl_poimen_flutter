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
    phoneNumber: json['phoneNumber'] as String?,
    whatsappNumber: json['whatsappNumber'] as String?,
  );
}

Map<String, dynamic> _$MemberForListToJson(MemberForList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
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

ChurchForMemberList _$ChurchForMemberListFromJson(Map<String, dynamic> json) {
  return ChurchForMemberList(
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
        : MemberForList.fromJson(json['leader'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ChurchForMemberListToJson(
        ChurchForMemberList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'name': instance.name,
      'leader': instance.leader,
      'sheep': instance.sheep,
      'goats': instance.goats,
      'deer': instance.deer,
    };
