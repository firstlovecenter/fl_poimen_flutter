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

ServicesForTrends _$ServicesForTrendsFromJson(Map<String, dynamic> json) =>
    ServicesForTrends(
      id: json['id'] as String,
      serviceDate:
          TimeGraph.fromJson(json['serviceDate'] as Map<String, dynamic>),
      attendance: json['attendance'] as int,
      membersPresentFromFellowshipCount:
          json['membersPresentFromFellowshipCount'] as int,
      membersAbsentFromFellowshipCount:
          json['membersAbsentFromFellowshipCount'] as int,
    )..typename = json['typename'] as String;

Map<String, dynamic> _$ServicesForTrendsToJson(ServicesForTrends instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'serviceDate': instance.serviceDate,
      'attendance': instance.attendance,
      'membersPresentFromFellowshipCount':
          instance.membersPresentFromFellowshipCount,
      'membersAbsentFromFellowshipCount':
          instance.membersAbsentFromFellowshipCount,
    };

ChurchForMembershipAttendanceTrends
    _$ChurchForMembershipAttendanceTrendsFromJson(Map<String, dynamic> json) =>
        ChurchForMembershipAttendanceTrends(
          sheepCount: json['sheepCount'] as int,
          goatsCount: json['goatsCount'] as int,
          deerCount: json['deerCount'] as int,
          lostCount: json['lostCount'] as int,
          services: (json['services'] as List<dynamic>)
              .map((e) => ServicesForTrends.fromJson(e as Map<String, dynamic>))
              .toList(),
          bussing: (json['bussing'] as List<dynamic>)
              .map((e) => ServicesForTrends.fromJson(e as Map<String, dynamic>))
              .toList(),
          leader:
              MemberForList.fromJson(json['leader'] as Map<String, dynamic>),
        )
          ..id = json['id'] as String
          ..typename = json['typename'] as String
          ..name = json['name'] as String
          ..admin = json['admin'] == null
              ? null
              : MemberForList.fromJson(json['admin'] as Map<String, dynamic>);

Map<String, dynamic> _$ChurchForMembershipAttendanceTrendsToJson(
        ChurchForMembershipAttendanceTrends instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'name': instance.name,
      'admin': instance.admin,
      'sheepCount': instance.sheepCount,
      'goatsCount': instance.goatsCount,
      'deerCount': instance.deerCount,
      'lostCount': instance.lostCount,
      'services': instance.services,
      'bussing': instance.bussing,
      'leader': instance.leader,
    };
