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
      imclTotal: (json['imclTotal'] as num).toInt(),
      fellowshipServiceAttendanceDefaultersCount:
          (json['fellowshipServiceAttendanceDefaultersCount'] as num?)?.toInt(),
      fellowshipBussingAttendanceDefaultersCount:
          (json['fellowshipBussingAttendanceDefaultersCount'] as num?)?.toInt(),
      outstandingVisitationsCount:
          (json['outstandingVisitationsCount'] as num?)?.toInt(),
      outstandingPrayerCount: (json['outstandingPrayerCount'] as num?)?.toInt(),
      outstandingTelepastoringCount:
          (json['outstandingTelepastoringCount'] as num?)?.toInt(),
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
      'fellowshipServiceAttendanceDefaultersCount':
          instance.fellowshipServiceAttendanceDefaultersCount,
      'fellowshipBussingAttendanceDefaultersCount':
          instance.fellowshipBussingAttendanceDefaultersCount,
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
      numberOfDays: (json['numberOfDays'] as num).toInt(),
    );

Map<String, dynamic> _$PastoralCycleToJson(PastoralCycle instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'numberOfDays': instance.numberOfDays,
    };
