// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models_imcl.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChurchForImclList _$ChurchForImclListFromJson(Map<String, dynamic> json) {
  return ChurchForImclList(
    imcls: (json['imcls'] as List<dynamic>)
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

Map<String, dynamic> _$ChurchForImclListToJson(ChurchForImclList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'name': instance.name,
      'leader': instance.leader,
      'imcls': instance.imcls,
    };
