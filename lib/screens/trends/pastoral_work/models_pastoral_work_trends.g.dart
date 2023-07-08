// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models_pastoral_work_trends.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VisitationActivity _$VisitationActivityFromJson(Map<String, dynamic> json) =>
    VisitationActivity(
      id: json['id'] as String,
      typename: json['typename'] as String,
      datetime: DateTime.parse(json['datetime'] as String),
      location: json['location'] as String,
      picture: json['picture'] as String,
      comment:
          PastoralComments.fromJson(json['comment'] as Map<String, dynamic>),
      memberVisited:
          MemberForList.fromJson(json['memberVisited'] as Map<String, dynamic>),
      pastoralCycle:
          PastoralCycle.fromJson(json['pastoralCycle'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VisitationActivityToJson(VisitationActivity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'datetime': instance.datetime.toIso8601String(),
      'location': instance.location,
      'picture': instance.picture,
      'comment': instance.comment,
      'memberVisited': instance.memberVisited,
      'pastoralCycle': instance.pastoralCycle,
    };

PrayerActivity _$PrayerActivityFromJson(Map<String, dynamic> json) =>
    PrayerActivity(
      id: json['id'] as String,
      datetime: DateTime.parse(json['datetime'] as String),
      comment:
          PastoralComments.fromJson(json['comment'] as Map<String, dynamic>),
      memberPrayedFor: MemberForList.fromJson(
          json['memberPrayedFor'] as Map<String, dynamic>),
      pastoralCycle:
          PastoralCycle.fromJson(json['pastoralCycle'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PrayerActivityToJson(PrayerActivity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'datetime': instance.datetime.toIso8601String(),
      'comment': instance.comment,
      'memberPrayedFor': instance.memberPrayedFor,
      'pastoralCycle': instance.pastoralCycle,
    };

TelepastoringActivity _$TelepastoringActivityFromJson(
        Map<String, dynamic> json) =>
    TelepastoringActivity(
      id: json['id'] as String,
      datetime: DateTime.parse(json['datetime'] as String),
      comment:
          PastoralComments.fromJson(json['comment'] as Map<String, dynamic>),
      memberTelepastored: MemberForList.fromJson(
          json['memberTelepastored'] as Map<String, dynamic>),
      pastoralCycle:
          PastoralCycle.fromJson(json['pastoralCycle'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TelepastoringActivityToJson(
        TelepastoringActivity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'datetime': instance.datetime.toIso8601String(),
      'comment': instance.comment,
      'memberTelepastored': instance.memberTelepastored,
      'pastoralCycle': instance.pastoralCycle,
    };

PastoralCycleForTrends _$PastoralCycleForTrendsFromJson(
        Map<String, dynamic> json) =>
    PastoralCycleForTrends(
      visitationsByChurch: VisitationActivity.fromJson(
          json['visitationsByChurch'] as Map<String, dynamic>),
      prayersByChurch: PrayerActivity.fromJson(
          json['prayersByChurch'] as Map<String, dynamic>),
      telepastoringsByChurch: TelepastoringActivity.fromJson(
          json['telepastoringsByChurch'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PastoralCycleForTrendsToJson(
        PastoralCycleForTrends instance) =>
    <String, dynamic>{
      'visitationsByChurch': instance.visitationsByChurch,
      'prayersByChurch': instance.prayersByChurch,
      'telepastoringsByChurch': instance.telepastoringsByChurch,
    };

ChurchForPastoralWorkTrends _$ChurchForPastoralWorkTrendsFromJson(
        Map<String, dynamic> json) =>
    ChurchForPastoralWorkTrends(
      pastoralCycles: PastoralCycleForTrends.fromJson(
          json['pastoralCycles'] as Map<String, dynamic>),
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

Map<String, dynamic> _$ChurchForPastoralWorkTrendsToJson(
        ChurchForPastoralWorkTrends instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'name': instance.name,
      'leader': instance.leader,
      'admin': instance.admin,
      'pastoralCycles': instance.pastoralCycles,
    };
