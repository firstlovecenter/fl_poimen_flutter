// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models_trends.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChurchForTrendsMenu _$ChurchForTrendsMenuFromJson(Map<String, dynamic> json) =>
    ChurchForTrendsMenu(
      currentPastoralCycle: PastoralCycle.fromJson(
          json['currentPastoralCycle'] as Map<String, dynamic>),
      leader: MemberForList.fromJson(json['leader'] as Map<String, dynamic>),
    )
      ..id = json['id'] as String
      ..typename = json['typename'] as String
      ..name = json['name'] as String
      ..admin = json['admin'] == null
          ? null
          : MemberForList.fromJson(json['admin'] as Map<String, dynamic>);

Map<String, dynamic> _$ChurchForTrendsMenuToJson(
        ChurchForTrendsMenu instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'name': instance.name,
      'admin': instance.admin,
      'currentPastoralCycle': instance.currentPastoralCycle,
      'leader': instance.leader,
    };
