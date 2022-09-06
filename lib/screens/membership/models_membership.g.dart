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
    leader: Member.fromJson(json['leader'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ChurchToJson(Church instance) => <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'name': instance.name,
      'leader': instance.leader,
    };

Member _$MemberFromJson(Map<String, dynamic> json) {
  return Member(
    id: json['id'] as String,
    typename: json['typename'] as String,
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    pictureUrl: json['pictureUrl'] as String,
    gender: Map<String, String>.from(json['gender'] as Map),
    dob: Map<String, String>.from(json['dob'] as Map),
    phoneNumber: json['phoneNumber'] as String,
    whatsappNumber: json['whatsappNumber'] as String,
    stream_name: _$enumDecode(_$ChurchLevelEnumMap, json['stream_name']),
    ministry: json['ministry'] == null
        ? null
        : Church.fromJson(json['ministry'] as Map<String, dynamic>),
    fellowship: Church.fromJson(json['fellowship'] as Map<String, dynamic>),
  )..lastFourServices = (json['lastFourServices'] as List<dynamic>)
      .map((e) => e as bool)
      .toList();
}

Map<String, dynamic> _$MemberToJson(Member instance) => <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'pictureUrl': instance.pictureUrl,
      'lastFourServices': instance.lastFourServices,
      'gender': instance.gender,
      'dob': instance.dob,
      'phoneNumber': instance.phoneNumber,
      'whatsappNumber': instance.whatsappNumber,
      'stream_name': _$ChurchLevelEnumMap[instance.stream_name],
      'fellowship': instance.fellowship,
      'ministry': instance.ministry,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$ChurchLevelEnumMap = {
  ChurchLevel.fellowship: 'fellowship',
  ChurchLevel.bacenta: 'bacenta',
  ChurchLevel.constituency: 'constituency',
  ChurchLevel.council: 'council',
  ChurchLevel.stream: 'stream',
  ChurchLevel.gathering: 'gathering',
};

ChurchForMemberList _$ChurchForMemberListFromJson(Map<String, dynamic> json) {
  return ChurchForMemberList(
    id: json['id'] as String,
    name: json['name'] as String,
    sheep: (json['sheep'] as List<dynamic>)
        .map((e) => Member.fromJson(e as Map<String, dynamic>))
        .toList(),
    goats: (json['goats'] as List<dynamic>)
        .map((e) => Member.fromJson(e as Map<String, dynamic>))
        .toList(),
    deer: (json['deer'] as List<dynamic>)
        .map((e) => Member.fromJson(e as Map<String, dynamic>))
        .toList(),
  )..typename = json['typename'] as String;
}

Map<String, dynamic> _$ChurchForMemberListToJson(
        ChurchForMemberList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'name': instance.name,
      'sheep': instance.sheep,
      'goats': instance.goats,
      'deer': instance.deer,
    };
