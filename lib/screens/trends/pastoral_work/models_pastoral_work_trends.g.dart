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

PastoralCycleForTrends _$PastoralCycleForTrendsFromJson(
        Map<String, dynamic> json) =>
    PastoralCycleForTrends(
      id: json['id'] as String,
      typename: json['typename'] as String,
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      numberOfDays: json['numberOfDays'] as int,
      visitationsByChurch: (json['visitationsByChurch'] as List<dynamic>)
          .map((e) =>
              VisitationActivityForTrends.fromJson(e as Map<String, dynamic>))
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
      'visitationsByChurch': instance.visitationsByChurch,
    };

ChurchForPastoralWorkTrends _$ChurchForPastoralWorkTrendsFromJson(
        Map<String, dynamic> json) =>
    ChurchForPastoralWorkTrends(
      pastoralCycles: (json['pastoralCycles'] as List<dynamic>)
          .map(
              (e) => PastoralCycleForTrends.fromJson(e as Map<String, dynamic>))
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
