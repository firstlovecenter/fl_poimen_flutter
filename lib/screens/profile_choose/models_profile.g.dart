// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileChurch _$ProfileChurchFromJson(Map<String, dynamic> json) {
  return ProfileChurch(
    id: json['id'] as String,
    typename: json['typename'] as String,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$ProfileChurchToJson(ProfileChurch instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'name': instance.name,
    };

Profile _$ProfileFromJson(Map<String, dynamic> json) {
  return Profile(
    id: json['id'] as String,
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    pictureUrl: json['pictureUrl'] as String,
    leadsFellowship: (json['leadsFellowship'] as List<dynamic>)
        .map((e) => ProfileChurch.fromJson(e as Map<String, dynamic>))
        .toList(),
    leadsBacenta: (json['leadsBacenta'] as List<dynamic>)
        .map((e) => ProfileChurch.fromJson(e as Map<String, dynamic>))
        .toList(),
    leadsConstituency: (json['leadsConstituency'] as List<dynamic>)
        .map((e) => ProfileChurch.fromJson(e as Map<String, dynamic>))
        .toList(),
    leadsSonta: (json['leadsSonta'] as List<dynamic>)
        .map((e) => ProfileChurch.fromJson(e as Map<String, dynamic>))
        .toList(),
    leadsCouncil: (json['leadsCouncil'] as List<dynamic>)
        .map((e) => ProfileChurch.fromJson(e as Map<String, dynamic>))
        .toList(),
    leadsGatheringService: (json['leadsGatheringService'] as List<dynamic>)
        .map((e) => ProfileChurch.fromJson(e as Map<String, dynamic>))
        .toList(),
    isAdminForGatheringService:
        (json['isAdminForGatheringService'] as List<dynamic>)
            .map((e) => ProfileChurch.fromJson(e as Map<String, dynamic>))
            .toList(),
  );
}

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'pictureUrl': instance.pictureUrl,
      'leadsFellowship': instance.leadsFellowship,
      'leadsBacenta': instance.leadsBacenta,
      'leadsConstituency': instance.leadsConstituency,
      'leadsSonta': instance.leadsSonta,
      'leadsCouncil': instance.leadsCouncil,
      'leadsGatheringService': instance.leadsGatheringService,
      'isAdminForGatheringService': instance.isAdminForGatheringService,
    };
