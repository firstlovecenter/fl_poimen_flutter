// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models_prayer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OutstandingPrayerForList _$OutstandingPrayerForListFromJson(
        Map<String, dynamic> json) =>
    OutstandingPrayerForList(
      id: json['id'] as String,
      typename: json['typename'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      pictureUrl: json['pictureUrl'] as String,
      status: json['status'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      whatsappNumber: json['whatsappNumber'] as String?,
    )..lost = json['lost'] as bool?;

Map<String, dynamic> _$OutstandingPrayerForListToJson(
        OutstandingPrayerForList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'status': instance.status,
      'lost': instance.lost,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'pictureUrl': instance.pictureUrl,
      'phoneNumber': instance.phoneNumber,
      'whatsappNumber': instance.whatsappNumber,
    };

CompletedPrayerForList _$CompletedPrayerForListFromJson(
        Map<String, dynamic> json) =>
    CompletedPrayerForList(
      id: json['id'] as String,
      typename: json['typename'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      pictureUrl: json['pictureUrl'] as String,
      status: json['status'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      whatsappNumber: json['whatsappNumber'] as String?,
    )..lost = json['lost'] as bool?;

Map<String, dynamic> _$CompletedPrayerForListToJson(
        CompletedPrayerForList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'status': instance.status,
      'lost': instance.lost,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'pictureUrl': instance.pictureUrl,
      'phoneNumber': instance.phoneNumber,
      'whatsappNumber': instance.whatsappNumber,
    };

ChurchForOutstandingPrayerList _$ChurchForOutstandingPrayerListFromJson(
        Map<String, dynamic> json) =>
    ChurchForOutstandingPrayerList(
      outstandingPrayer: (json['outstandingPrayer'] as List<dynamic>)
          .map((e) =>
              OutstandingPrayerForList.fromJson(e as Map<String, dynamic>))
          .toList(),
      completedPrayerCount: json['completedPrayerCount'] as int,
    )
      ..id = json['id'] as String
      ..typename = json['typename'] as String
      ..name = json['name'] as String
      ..leader = json['leader'] == null
          ? null
          : MemberForList.fromJson(json['leader'] as Map<String, dynamic>);

Map<String, dynamic> _$ChurchForOutstandingPrayerListToJson(
        ChurchForOutstandingPrayerList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'name': instance.name,
      'leader': instance.leader,
      'completedPrayerCount': instance.completedPrayerCount,
      'outstandingPrayer': instance.outstandingPrayer,
    };

ChurchForCompletedPrayerList _$ChurchForCompletedPrayerListFromJson(
        Map<String, dynamic> json) =>
    ChurchForCompletedPrayerList(
      completedPrayer: (json['completedPrayer'] as List<dynamic>)
          .map(
              (e) => CompletedPrayerForList.fromJson(e as Map<String, dynamic>))
          .toList(),
      outstandingPrayerCount: json['outstandingPrayerCount'] as int,
    )
      ..id = json['id'] as String
      ..typename = json['typename'] as String
      ..name = json['name'] as String
      ..leader = json['leader'] == null
          ? null
          : MemberForList.fromJson(json['leader'] as Map<String, dynamic>);

Map<String, dynamic> _$ChurchForCompletedPrayerListToJson(
        ChurchForCompletedPrayerList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'name': instance.name,
      'leader': instance.leader,
      'outstandingPrayerCount': instance.outstandingPrayerCount,
      'completedPrayer': instance.completedPrayer,
    };
