// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models_my_leaders_trends.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChurchWithSubChurchList _$ChurchWithSubChurchListFromJson(
        Map<String, dynamic> json) =>
    ChurchWithSubChurchList(
      subChurches: (json['subChurches'] as List<dynamic>)
          .map((e) => Church.fromJson(e as Map<String, dynamic>))
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

Map<String, dynamic> _$ChurchWithSubChurchListToJson(
        ChurchWithSubChurchList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'name': instance.name,
      'leader': instance.leader,
      'admin': instance.admin,
      'subChurches': instance.subChurches,
    };
