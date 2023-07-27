// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models_my_leaders_trends.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MembershipData _$MembershipDataFromJson(Map<String, dynamic> json) =>
    MembershipData(
      id: json['id'] as String,
      typename: json['typename'] as String,
      sheepCount: json['sheepCount'] as int,
      deerCount: json['deerCount'] as int,
      goatsCount: json['goatsCount'] as int,
      membersCount: json['membersCount'] as int,
    );

Map<String, dynamic> _$MembershipDataToJson(MembershipData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'sheepCount': instance.sheepCount,
      'deerCount': instance.deerCount,
      'goatsCount': instance.goatsCount,
      'membersCount': instance.membersCount,
    };

ChurchForOverallCycleAssessment _$ChurchForOverallCycleAssessmentFromJson(
        Map<String, dynamic> json) =>
    ChurchForOverallCycleAssessment(
      memberCount: json['memberCount'] as int,
      completedVisitationsCount: json['completedVisitationsCount'] as int,
      completedPrayersCount: json['completedPrayersCount'] as int,
      completedTelepastoringCount: json['completedTelepastoringCount'] as int,
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

Map<String, dynamic> _$ChurchForOverallCycleAssessmentToJson(
        ChurchForOverallCycleAssessment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'name': instance.name,
      'leader': instance.leader,
      'admin': instance.admin,
      'memberCount': instance.memberCount,
      'completedVisitationsCount': instance.completedVisitationsCount,
      'completedTelepastoringCount': instance.completedTelepastoringCount,
      'completedPrayersCount': instance.completedPrayersCount,
    };

ChurchWithSubChurchList _$ChurchWithSubChurchListFromJson(
        Map<String, dynamic> json) =>
    ChurchWithSubChurchList(
      subChurches: (json['subChurches'] as List<dynamic>)
          .map((e) => ChurchForOverallCycleAssessment.fromJson(
              e as Map<String, dynamic>))
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
