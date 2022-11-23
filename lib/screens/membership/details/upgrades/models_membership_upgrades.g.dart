// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models_membership_upgrades.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberWithUpgrades _$MemberWithUpgradesFromJson(Map<String, dynamic> json) {
  return MemberWithUpgrades(
    hasHolyGhostBaptism: json['hasHolyGhostBaptism'] as bool,
    hasWaterBaptism: json['hasWaterBaptism'] as bool,
    graduatedUnderstandingSchools:
        (json['graduatedUnderstandingSchools'] as List<dynamic>)
            .map((e) => e as String)
            .toList(),
    hasAudioCollections: json['hasAudioCollections'] as bool,
    hasBibleTranslations: json['hasBibleTranslations'] as bool,
    attendedCampsWithProphet:
        (json['attendedCampsWithProphet'] as List<dynamic>)
            .map((e) => e as String)
            .toList(),
    attendedCampsWithOtherBishops:
        (json['attendedCampsWithOtherBishops'] as List<dynamic>)
            .map((e) => e as String)
            .toList(),
    hasHolyGhostBaptismDate: json['hasHolyGhostBaptismDate'] == null
        ? null
        : DateTime.parse(json['hasHolyGhostBaptismDate'] as String),
    hasWaterBaptismDate: json['hasWaterBaptismDate'] == null
        ? null
        : DateTime.parse(json['hasWaterBaptismDate'] as String),
  )
    ..id = json['id'] as String
    ..typename = json['typename'] as String
    ..status = json['status'] as String?
    ..lost = json['lost'] as bool?
    ..firstName = json['firstName'] as String
    ..lastName = json['lastName'] as String
    ..pictureUrl = json['pictureUrl'] as String
    ..phoneNumber = json['phoneNumber'] as String?
    ..whatsappNumber = json['whatsappNumber'] as String?;
}

Map<String, dynamic> _$MemberWithUpgradesToJson(MemberWithUpgrades instance) =>
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
      'hasHolyGhostBaptism': instance.hasHolyGhostBaptism,
      'hasHolyGhostBaptismDate':
          instance.hasHolyGhostBaptismDate?.toIso8601String(),
      'hasWaterBaptism': instance.hasWaterBaptism,
      'hasWaterBaptismDate': instance.hasWaterBaptismDate?.toIso8601String(),
      'graduatedUnderstandingSchools': instance.graduatedUnderstandingSchools,
      'hasAudioCollections': instance.hasAudioCollections,
      'hasBibleTranslations': instance.hasBibleTranslations,
      'attendedCampsWithProphet': instance.attendedCampsWithProphet,
      'attendedCampsWithOtherBishops': instance.attendedCampsWithOtherBishops,
    };
