// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models_membership_upgrades.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpiritualProgression _$SpiritualProgressionFromJson(
        Map<String, dynamic> json) =>
    SpiritualProgression(
      salvation: json['salvation'] as bool,
      waterBaptism: json['waterBaptism'] as bool,
      holyGhostBaptism: json['holyGhostBaptism'] as bool,
      newBelieversSchool: json['newBelieversSchool'] as bool,
      strongChristiansAcademy: json['strongChristiansAcademy'] as bool,
      understandingSchools1: json['understandingSchools1'] as bool,
      understandingSchools2: json['understandingSchools2'] as bool,
      understandingSchools3: json['understandingSchools3'] as bool,
      attendedCamp1: json['attendedCamp1'] as bool,
      attendedCamp2: json['attendedCamp2'] as bool,
      attendedCamp3: json['attendedCamp3'] as bool,
      foundersIntimateCounselling: json['foundersIntimateCounselling'] as bool,
      leadPastorIntimateCounselling:
          json['leadPastorIntimateCounselling'] as bool,
      bacentaLeader: json['bacentaLeader'] as bool,
      basontaLeader: json['basontaLeader'] as bool,
      creativeArtsLeader: json['creativeArtsLeader'] as bool,
      pastor: json['pastor'] as bool,
      hasMakariosCollection: json['hasMakariosCollection'] as bool,
      hasAudioCollection: json['hasAudioCollection'] as bool,
      onBacentaWhatsappGroup: json['onBacentaWhatsappGroup'] as bool,
    );

Map<String, dynamic> _$SpiritualProgressionToJson(
        SpiritualProgression instance) =>
    <String, dynamic>{
      'salvation': instance.salvation,
      'waterBaptism': instance.waterBaptism,
      'holyGhostBaptism': instance.holyGhostBaptism,
      'newBelieversSchool': instance.newBelieversSchool,
      'strongChristiansAcademy': instance.strongChristiansAcademy,
      'understandingSchools1': instance.understandingSchools1,
      'understandingSchools2': instance.understandingSchools2,
      'understandingSchools3': instance.understandingSchools3,
      'attendedCamp1': instance.attendedCamp1,
      'attendedCamp2': instance.attendedCamp2,
      'attendedCamp3': instance.attendedCamp3,
      'foundersIntimateCounselling': instance.foundersIntimateCounselling,
      'leadPastorIntimateCounselling': instance.leadPastorIntimateCounselling,
      'bacentaLeader': instance.bacentaLeader,
      'basontaLeader': instance.basontaLeader,
      'creativeArtsLeader': instance.creativeArtsLeader,
      'pastor': instance.pastor,
      'hasMakariosCollection': instance.hasMakariosCollection,
      'hasAudioCollection': instance.hasAudioCollection,
      'onBacentaWhatsappGroup': instance.onBacentaWhatsappGroup,
    };

MemberWithSpiritualProgression _$MemberWithSpiritualProgressionFromJson(
        Map<String, dynamic> json) =>
    MemberWithSpiritualProgression(
      spiritualProgression: json['spiritualProgression'] == null
          ? null
          : SpiritualProgression.fromJson(
              json['spiritualProgression'] as Map<String, dynamic>),
    )
      ..id = json['id'] as String
      ..typename = json['typename'] as String
      ..status = json['status'] as String?
      ..lost = json['lost'] as bool?
      ..firstName = json['firstName'] as String
      ..lastName = json['lastName'] as String
      ..pictureUrl = json['pictureUrl'] as String
      ..phoneNumber = json['phoneNumber'] as String
      ..whatsappNumber = json['whatsappNumber'] as String;

Map<String, dynamic> _$MemberWithSpiritualProgressionToJson(
        MemberWithSpiritualProgression instance) =>
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
      'spiritualProgression': instance.spiritualProgression,
    };

LifeProgression _$LifeProgressionFromJson(Map<String, dynamic> json) =>
    LifeProgression(
      married: json['married'] as bool,
      childbirth: json['childbirth'] as bool,
      universityEducation: json['universityEducation'] as bool,
      ownsHouseOrBuildingProject: json['ownsHouseOrBuildingProject'] as bool,
    );

Map<String, dynamic> _$LifeProgressionToJson(LifeProgression instance) =>
    <String, dynamic>{
      'married': instance.married,
      'childbirth': instance.childbirth,
      'universityEducation': instance.universityEducation,
      'ownsHouseOrBuildingProject': instance.ownsHouseOrBuildingProject,
    };

MemberWithLifeProgression _$MemberWithLifeProgressionFromJson(
        Map<String, dynamic> json) =>
    MemberWithLifeProgression(
      lifeProgression: json['lifeProgression'] == null
          ? null
          : LifeProgression.fromJson(
              json['lifeProgression'] as Map<String, dynamic>),
    )
      ..id = json['id'] as String
      ..typename = json['typename'] as String
      ..status = json['status'] as String?
      ..lost = json['lost'] as bool?
      ..firstName = json['firstName'] as String
      ..lastName = json['lastName'] as String
      ..pictureUrl = json['pictureUrl'] as String
      ..phoneNumber = json['phoneNumber'] as String
      ..whatsappNumber = json['whatsappNumber'] as String;

Map<String, dynamic> _$MemberWithLifeProgressionToJson(
        MemberWithLifeProgression instance) =>
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
      'lifeProgression': instance.lifeProgression,
    };
