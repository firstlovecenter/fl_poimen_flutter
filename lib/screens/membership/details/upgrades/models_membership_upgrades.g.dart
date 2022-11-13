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
    hasBibleTranslations: (json['hasBibleTranslations'] as List<dynamic>)
        .map((e) => e as String)
        .toList(),
    attendedCampsWithProphet:
        (json['attendedCampsWithProphet'] as List<dynamic>)
            .map((e) => e as String)
            .toList(),
    attendedCampsWithOtherBishops:
        (json['attendedCampsWithOtherBishops'] as List<dynamic>)
            .map((e) => e as String)
            .toList(),
  )
    ..id = json['id'] as String
    ..typename = json['typename'] as String
    ..status = json['status'] as String?
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
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'pictureUrl': instance.pictureUrl,
      'phoneNumber': instance.phoneNumber,
      'whatsappNumber': instance.whatsappNumber,
      'hasHolyGhostBaptism': instance.hasHolyGhostBaptism,
      'hasWaterBaptism': instance.hasWaterBaptism,
      'graduatedUnderstandingSchools': instance.graduatedUnderstandingSchools,
      'hasAudioCollections': instance.hasAudioCollections,
      'hasBibleTranslations': instance.hasBibleTranslations,
      'attendedCampsWithProphet': instance.attendedCampsWithProphet,
      'attendedCampsWithOtherBishops': instance.attendedCampsWithOtherBishops,
    };
