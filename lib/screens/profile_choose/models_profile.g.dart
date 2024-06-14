// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileChurch _$ProfileChurchFromJson(Map<String, dynamic> json) =>
    ProfileChurch(
      id: json['id'] as String,
      typename: json['typename'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$ProfileChurchToJson(ProfileChurch instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'name': instance.name,
    };

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      pictureUrl: json['pictureUrl'] as String,
      leadsBacenta: (json['leadsBacenta'] as List<dynamic>)
          .map((e) => ProfileChurch.fromJson(e as Map<String, dynamic>))
          .toList(),
      leadsConstituency: (json['leadsConstituency'] as List<dynamic>)
          .map((e) => ProfileChurch.fromJson(e as Map<String, dynamic>))
          .toList(),
      isAdminForConstituency: (json['isAdminForConstituency'] as List<dynamic>)
          .map((e) => ProfileChurch.fromJson(e as Map<String, dynamic>))
          .toList(),
      leadsCouncil: (json['leadsCouncil'] as List<dynamic>)
          .map((e) => ProfileChurch.fromJson(e as Map<String, dynamic>))
          .toList(),
      isAdminForCouncil: (json['isAdminForCouncil'] as List<dynamic>)
          .map((e) => ProfileChurch.fromJson(e as Map<String, dynamic>))
          .toList(),
      leadsStream: (json['leadsStream'] as List<dynamic>)
          .map((e) => ProfileChurch.fromJson(e as Map<String, dynamic>))
          .toList(),
      isAdminForStream: (json['isAdminForStream'] as List<dynamic>)
          .map((e) => ProfileChurch.fromJson(e as Map<String, dynamic>))
          .toList(),
      leadsCampus: (json['leadsCampus'] as List<dynamic>)
          .map((e) => ProfileChurch.fromJson(e as Map<String, dynamic>))
          .toList(),
      isAdminForCampus: (json['isAdminForCampus'] as List<dynamic>)
          .map((e) => ProfileChurch.fromJson(e as Map<String, dynamic>))
          .toList(),
      leadsHub: (json['leadsHub'] as List<dynamic>)
          .map((e) => ProfileChurch.fromJson(e as Map<String, dynamic>))
          .toList(),
      leadsHubCouncil: (json['leadsHubCouncil'] as List<dynamic>)
          .map((e) => ProfileChurch.fromJson(e as Map<String, dynamic>))
          .toList(),
      leadsMinistry: (json['leadsMinistry'] as List<dynamic>)
          .map((e) => ProfileChurch.fromJson(e as Map<String, dynamic>))
          .toList(),
      isAdminForMinistry: (json['isAdminForMinistry'] as List<dynamic>)
          .map((e) => ProfileChurch.fromJson(e as Map<String, dynamic>))
          .toList(),
      leadsCreativeArts: (json['leadsCreativeArts'] as List<dynamic>)
          .map((e) => ProfileChurch.fromJson(e as Map<String, dynamic>))
          .toList(),
      isAdminForCreativeArts: (json['isAdminForCreativeArts'] as List<dynamic>)
          .map((e) => ProfileChurch.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'pictureUrl': instance.pictureUrl,
      'leadsBacenta': instance.leadsBacenta,
      'leadsConstituency': instance.leadsConstituency,
      'isAdminForConstituency': instance.isAdminForConstituency,
      'leadsCouncil': instance.leadsCouncil,
      'isAdminForCouncil': instance.isAdminForCouncil,
      'leadsStream': instance.leadsStream,
      'isAdminForStream': instance.isAdminForStream,
      'leadsCampus': instance.leadsCampus,
      'isAdminForCampus': instance.isAdminForCampus,
      'leadsHub': instance.leadsHub,
      'leadsHubCouncil': instance.leadsHubCouncil,
      'leadsMinistry': instance.leadsMinistry,
      'isAdminForMinistry': instance.isAdminForMinistry,
      'leadsCreativeArts': instance.leadsCreativeArts,
      'isAdminForCreativeArts': instance.isAdminForCreativeArts,
    };
