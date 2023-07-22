// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models_trends.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChurchForTrendsMenu _$ChurchForTrendsMenuFromJson(Map<String, dynamic> json) =>
    ChurchForTrendsMenu(
      currentPastoralCycle: json['currentPastoralCycle'] == null
          ? null
          : PastoralCycle.fromJson(
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

ServiceWeeksForTrends _$ServiceWeeksForTrendsFromJson(
        Map<String, dynamic> json) =>
    ServiceWeeksForTrends(
      week: json['week'] as int,
      typename: json['typename'] as String,
      attendance: json['attendance'] as int,
      membersPresentAtWeekdayCount: json['membersPresentAtWeekdayCount'] as int,
      membersAbsentAtWeekdayCount: json['membersAbsentAtWeekdayCount'] as int,
    );

Map<String, dynamic> _$ServiceWeeksForTrendsToJson(
        ServiceWeeksForTrends instance) =>
    <String, dynamic>{
      'week': instance.week,
      'typename': instance.typename,
      'attendance': instance.attendance,
      'membersPresentAtWeekdayCount': instance.membersPresentAtWeekdayCount,
      'membersAbsentAtWeekdayCount': instance.membersAbsentAtWeekdayCount,
    };

BussingWeeksForTrends _$BussingWeeksForTrendsFromJson(
        Map<String, dynamic> json) =>
    BussingWeeksForTrends(
      week: json['week'] as int,
      typename: json['typename'] as String,
      attendance: json['attendance'] as int,
      membersPresentAtWeekendCount: json['membersPresentAtWeekendCount'] as int,
      membersAbsentAtWeekendCount: json['membersAbsentAtWeekendCount'] as int,
    );

Map<String, dynamic> _$BussingWeeksForTrendsToJson(
        BussingWeeksForTrends instance) =>
    <String, dynamic>{
      'week': instance.week,
      'typename': instance.typename,
      'attendance': instance.attendance,
      'membersPresentAtWeekendCount': instance.membersPresentAtWeekendCount,
      'membersAbsentAtWeekendCount': instance.membersAbsentAtWeekendCount,
    };

ChurchForMembershipAttendanceTrends
    _$ChurchForMembershipAttendanceTrendsFromJson(Map<String, dynamic> json) =>
        ChurchForMembershipAttendanceTrends(
          sheepCount: json['sheepCount'] as int,
          goatsCount: json['goatsCount'] as int,
          deerCount: json['deerCount'] as int,
          lostCount: json['lostCount'] as int,
          serviceWeeks: (json['serviceWeeks'] as List<dynamic>)
              .map((e) =>
                  ServiceWeeksForTrends.fromJson(e as Map<String, dynamic>))
              .toList(),
          bussingWeeks: (json['bussingWeeks'] as List<dynamic>)
              .map((e) =>
                  BussingWeeksForTrends.fromJson(e as Map<String, dynamic>))
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
      'serviceWeeks': instance.serviceWeeks,
      'bussingWeeks': instance.bussingWeeks,
      'leader': instance.leader,
    };
