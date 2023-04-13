// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models_home_screen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeScreenChurch _$HomeScreenChurchFromJson(Map<String, dynamic> json) =>
    HomeScreenChurch(
      id: json['id'] as String,
      typename: json['typename'] as String,
      name: json['name'] as String,
      imclTotal: json['imclTotal'] as int,
      fellowshipAttendanceDefaultersCount:
          json['fellowshipAttendanceDefaultersCount'] as int?,
      outstandingVisitationsCount: json['outstandingVisitationsCount'] as int?,
      outstandingPrayerCount: json['outstandingPrayerCount'] as int?,
      outstandingTelepastoringCount:
          json['outstandingTelepastoringCount'] as int?,
      currentPastoralCycle: json['currentPastoralCycle'] == null
          ? null
          : PastoralCycle.fromJson(
              json['currentPastoralCycle'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HomeScreenChurchToJson(HomeScreenChurch instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'name': instance.name,
      'imclTotal': instance.imclTotal,
      'fellowshipAttendanceDefaultersCount':
          instance.fellowshipAttendanceDefaultersCount,
      'outstandingVisitationsCount': instance.outstandingVisitationsCount,
      'outstandingPrayerCount': instance.outstandingPrayerCount,
      'outstandingTelepastoringCount': instance.outstandingTelepastoringCount,
      'currentPastoralCycle': instance.currentPastoralCycle,
    };

PastoralCycle _$PastoralCycleFromJson(Map<String, dynamic> json) =>
    PastoralCycle(
      id: json['id'] as String,
      typename: json['typename'] as String,
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      numberOfDays: json['numberOfDays'] as int,
    );

Map<String, dynamic> _$PastoralCycleToJson(PastoralCycle instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'numberOfDays': instance.numberOfDays,
    };
