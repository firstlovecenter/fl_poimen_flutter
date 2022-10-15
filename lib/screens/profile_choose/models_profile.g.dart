// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PastoralCycle _$PastoralCycleFromJson(Map<String, dynamic> json) {
  return PastoralCycle(
    typename: json['typename'] as String,
    startDate: json['startDate'] as String,
    endDate: json['endDate'] as String,
    numberOfDays: json['numberOfDays'] as int,
  );
}

Map<String, dynamic> _$PastoralCycleToJson(PastoralCycle instance) =>
    <String, dynamic>{
      'typename': instance.typename,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'numberOfDays': instance.numberOfDays,
    };

ProfileChurch _$ProfileChurchFromJson(Map<String, dynamic> json) {
  return ProfileChurch(
    id: json['id'] as String,
    typename: json['typename'] as String,
    name: json['name'] as String,
    imclTotal: json['imclTotal'] as int?,
    currentPastoralCycle: json['currentPastoralCycle'] == null
        ? null
        : PastoralCycle.fromJson(
            json['currentPastoralCycle'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ProfileChurchToJson(ProfileChurch instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'name': instance.name,
      'imclTotal': instance.imclTotal,
      'currentPastoralCycle': instance.currentPastoralCycle,
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
    leadsStream: (json['leadsStream'] as List<dynamic>)
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
      'leadsStream': instance.leadsStream,
      'leadsGatheringService': instance.leadsGatheringService,
      'isAdminForGatheringService': instance.isAdminForGatheringService,
    };
