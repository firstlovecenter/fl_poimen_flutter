// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models_idl.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChurchForIdlList _$ChurchForIdlListFromJson(Map<String, dynamic> json) =>
    ChurchForIdlList(
      idls: (json['idls'] as List<dynamic>)
          .map((e) => MemberForList.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..id = json['id'] as String
      ..typename = json['typename'] as String
      ..name = json['name'] as String
      ..leader = json['leader'] == null
          ? null
          : MemberForList.fromJson(json['leader'] as Map<String, dynamic>);

Map<String, dynamic> _$ChurchForIdlListToJson(ChurchForIdlList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'name': instance.name,
      'leader': instance.leader,
      'idls': instance.idls,
    };
