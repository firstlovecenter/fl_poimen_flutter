// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models_pastoral_work_trends.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VisitationActivityForTrends _$VisitationActivityForTrendsFromJson(
        Map<String, dynamic> json) =>
    VisitationActivityForTrends(
      id: json['id'] as String,
      typename: json['typename'] as String,
      datetime: DateTime.parse(json['datetime'] as String),
    );

Map<String, dynamic> _$VisitationActivityForTrendsToJson(
        VisitationActivityForTrends instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'datetime': instance.datetime.toIso8601String(),
    };

PrayerActivityForTrends _$PrayerActivityForTrendsFromJson(
        Map<String, dynamic> json) =>
    PrayerActivityForTrends(
      id: json['id'] as String,
      datetime: DateTime.parse(json['datetime'] as String),
    );

Map<String, dynamic> _$PrayerActivityForTrendsToJson(
        PrayerActivityForTrends instance) =>
    <String, dynamic>{
      'id': instance.id,
      'datetime': instance.datetime.toIso8601String(),
    };

TelepastoringActivityForTrends _$TelepastoringActivityForTrendsFromJson(
        Map<String, dynamic> json) =>
    TelepastoringActivityForTrends(
      id: json['id'] as String,
      datetime: DateTime.parse(json['datetime'] as String),
    );

Map<String, dynamic> _$TelepastoringActivityForTrendsToJson(
        TelepastoringActivityForTrends instance) =>
    <String, dynamic>{
      'id': instance.id,
      'datetime': instance.datetime.toIso8601String(),
    };

MembershipDataForTrends _$MembershipDataForTrendsFromJson(
        Map<String, dynamic> json) =>
    MembershipDataForTrends(
      id: json['id'] as String,
      typename: json['typename'] as String,
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      membersCount: (json['membersCount'] as num).toInt(),
      sheepCount: (json['sheepCount'] as num).toInt(),
      goatsCount: (json['goatsCount'] as num).toInt(),
      deerCount: (json['deerCount'] as num).toInt(),
    );

Map<String, dynamic> _$MembershipDataForTrendsToJson(
        MembershipDataForTrends instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'updatedAt': instance.updatedAt.toIso8601String(),
      'membersCount': instance.membersCount,
      'sheepCount': instance.sheepCount,
      'goatsCount': instance.goatsCount,
      'deerCount': instance.deerCount,
    };

PastoralCycleForTrends _$PastoralCycleForTrendsFromJson(
        Map<String, dynamic> json) =>
    PastoralCycleForTrends(
      id: json['id'] as String,
      typename: json['typename'] as String,
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      numberOfDays: (json['numberOfDays'] as num).toInt(),
      membershipDataByChurch: json['membershipDataByChurch'] == null
          ? null
          : MembershipDataForTrends.fromJson(
              json['membershipDataByChurch'] as Map<String, dynamic>),
      visitationsByChurch: (json['visitationsByChurch'] as List<dynamic>)
          .map((e) =>
              VisitationActivityForTrends.fromJson(e as Map<String, dynamic>))
          .toList(),
      prayersByChurch: (json['prayersByChurch'] as List<dynamic>)
          .map((e) =>
              PrayerActivityForTrends.fromJson(e as Map<String, dynamic>))
          .toList(),
      telepastoringsByChurch: (json['telepastoringsByChurch'] as List<dynamic>)
          .map((e) => TelepastoringActivityForTrends.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PastoralCycleForTrendsToJson(
        PastoralCycleForTrends instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'numberOfDays': instance.numberOfDays,
      'membershipDataByChurch': instance.membershipDataByChurch,
      'visitationsByChurch': instance.visitationsByChurch,
      'prayersByChurch': instance.prayersByChurch,
      'telepastoringsByChurch': instance.telepastoringsByChurch,
    };

PastoralCycleCountsForTrends _$PastoralCycleCountsForTrendsFromJson(
        Map<String, dynamic> json) =>
    PastoralCycleCountsForTrends(
      id: json['id'] as String,
      typename: json['typename'] as String,
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      numberOfDays: (json['numberOfDays'] as num).toInt(),
      membershipDataByChurch: json['membershipDataByChurch'] == null
          ? null
          : MembershipDataForTrends.fromJson(
              json['membershipDataByChurch'] as Map<String, dynamic>),
      visitationsByChurchCount:
          (json['visitationsByChurchCount'] as num).toInt(),
      prayersByChurchCount: (json['prayersByChurchCount'] as num).toInt(),
      telepastoringsByChurchCount:
          (json['telepastoringsByChurchCount'] as num).toInt(),
    );

Map<String, dynamic> _$PastoralCycleCountsForTrendsToJson(
        PastoralCycleCountsForTrends instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'numberOfDays': instance.numberOfDays,
      'membershipDataByChurch': instance.membershipDataByChurch,
      'visitationsByChurchCount': instance.visitationsByChurchCount,
      'prayersByChurchCount': instance.prayersByChurchCount,
      'telepastoringsByChurchCount': instance.telepastoringsByChurchCount,
    };

ChurchForPastoralWorkTrendsWithCounts
    _$ChurchForPastoralWorkTrendsWithCountsFromJson(
            Map<String, dynamic> json) =>
        ChurchForPastoralWorkTrendsWithCounts(
          pastoralCycles: (json['pastoralCycles'] as List<dynamic>)
              .map((e) => PastoralCycleCountsForTrends.fromJson(
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

Map<String, dynamic> _$ChurchForPastoralWorkTrendsWithCountsToJson(
        ChurchForPastoralWorkTrendsWithCounts instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'name': instance.name,
      'leader': instance.leader,
      'admin': instance.admin,
      'pastoralCycles': instance.pastoralCycles,
    };
