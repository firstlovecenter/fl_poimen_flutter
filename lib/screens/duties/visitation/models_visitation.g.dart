// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models_visitation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OutstandingVisitationForList _$OutstandingVisitationForListFromJson(
        Map<String, dynamic> json) =>
    OutstandingVisitationForList(
      id: json['id'] as String,
      typename: json['typename'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      pictureUrl: json['pictureUrl'] as String,
      phoneNumber: json['phoneNumber'] as String,
      whatsappNumber: json['whatsappNumber'] as String,
      status: json['status'] as String?,
    )..lost = json['lost'] as bool?;

Map<String, dynamic> _$OutstandingVisitationForListToJson(
        OutstandingVisitationForList instance) =>
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

CompletedVisitationForList _$CompletedVisitationForListFromJson(
        Map<String, dynamic> json) =>
    CompletedVisitationForList(
      id: json['id'] as String,
      typename: json['typename'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      pictureUrl: json['pictureUrl'] as String,
      phoneNumber: json['phoneNumber'] as String,
      whatsappNumber: json['whatsappNumber'] as String,
      status: json['status'] as String?,
    )..lost = json['lost'] as bool?;

Map<String, dynamic> _$CompletedVisitationForListToJson(
        CompletedVisitationForList instance) =>
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

ChurchForOutstandingVisitationList _$ChurchForOutstandingVisitationListFromJson(
        Map<String, dynamic> json) =>
    ChurchForOutstandingVisitationList(
      outstandingVisitations: (json['outstandingVisitations'] as List<dynamic>)
          .map((e) =>
              OutstandingVisitationForList.fromJson(e as Map<String, dynamic>))
          .toList(),
      completedVisitationsCount: json['completedVisitationsCount'] as int,
    )
      ..id = json['id'] as String
      ..typename = json['typename'] as String
      ..name = json['name'] as String
      ..leader = json['leader'] == null
          ? null
          : MemberForList.fromJson(json['leader'] as Map<String, dynamic>);

Map<String, dynamic> _$ChurchForOutstandingVisitationListToJson(
        ChurchForOutstandingVisitationList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'name': instance.name,
      'leader': instance.leader,
      'completedVisitationsCount': instance.completedVisitationsCount,
      'outstandingVisitations': instance.outstandingVisitations,
    };

ChurchForCompletedVisitationList _$ChurchForCompletedVisitationListFromJson(
        Map<String, dynamic> json) =>
    ChurchForCompletedVisitationList(
      completedVisitations: (json['completedVisitations'] as List<dynamic>)
          .map((e) =>
              CompletedVisitationForList.fromJson(e as Map<String, dynamic>))
          .toList(),
      outstandingVisitationsCount: json['outstandingVisitationsCount'] as int,
    )
      ..id = json['id'] as String
      ..typename = json['typename'] as String
      ..name = json['name'] as String
      ..leader = json['leader'] == null
          ? null
          : MemberForList.fromJson(json['leader'] as Map<String, dynamic>);

Map<String, dynamic> _$ChurchForCompletedVisitationListToJson(
        ChurchForCompletedVisitationList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'name': instance.name,
      'leader': instance.leader,
      'outstandingVisitationsCount': instance.outstandingVisitationsCount,
      'completedVisitations': instance.completedVisitations,
    };
