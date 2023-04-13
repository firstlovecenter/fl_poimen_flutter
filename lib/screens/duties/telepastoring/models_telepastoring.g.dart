// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models_telepastoring.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OutstandingTelepastoringForList _$OutstandingTelepastoringForListFromJson(
        Map<String, dynamic> json) =>
    OutstandingTelepastoringForList(
      id: json['id'] as String,
      typename: json['typename'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      pictureUrl: json['pictureUrl'] as String,
      phoneNumber: json['phoneNumber'] as String,
      whatsappNumber: json['whatsappNumber'] as String,
      status: json['status'] as String?,
    )..lost = json['lost'] as bool?;

Map<String, dynamic> _$OutstandingTelepastoringForListToJson(
        OutstandingTelepastoringForList instance) =>
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

CompletedTelepastoringForList _$CompletedTelepastoringForListFromJson(
        Map<String, dynamic> json) =>
    CompletedTelepastoringForList(
      id: json['id'] as String,
      typename: json['typename'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      pictureUrl: json['pictureUrl'] as String,
      phoneNumber: json['phoneNumber'] as String,
      whatsappNumber: json['whatsappNumber'] as String,
      status: json['status'] as String?,
    )..lost = json['lost'] as bool?;

Map<String, dynamic> _$CompletedTelepastoringForListToJson(
        CompletedTelepastoringForList instance) =>
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

ChurchForOutstandingTelepastoringList
    _$ChurchForOutstandingTelepastoringListFromJson(
            Map<String, dynamic> json) =>
        ChurchForOutstandingTelepastoringList(
          outstandingTelepastoring:
              (json['outstandingTelepastoring'] as List<dynamic>)
                  .map((e) => OutstandingTelepastoringForList.fromJson(
                      e as Map<String, dynamic>))
                  .toList(),
          completedTelepastoringCount:
              json['completedTelepastoringCount'] as int,
        )
          ..id = json['id'] as String
          ..typename = json['typename'] as String
          ..name = json['name'] as String
          ..leader = json['leader'] == null
              ? null
              : MemberForList.fromJson(json['leader'] as Map<String, dynamic>)
          ..admin = json['admin'] == null
              ? null
              : MemberForList.fromJson(json['admin'] as Map<String, dynamic>);

Map<String, dynamic> _$ChurchForOutstandingTelepastoringListToJson(
        ChurchForOutstandingTelepastoringList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'name': instance.name,
      'leader': instance.leader,
      'admin': instance.admin,
      'completedTelepastoringCount': instance.completedTelepastoringCount,
      'outstandingTelepastoring': instance.outstandingTelepastoring,
    };

ChurchForCompletedTelepastoringList
    _$ChurchForCompletedTelepastoringListFromJson(Map<String, dynamic> json) =>
        ChurchForCompletedTelepastoringList(
          completedTelepastoring:
              (json['completedTelepastoring'] as List<dynamic>)
                  .map((e) => CompletedTelepastoringForList.fromJson(
                      e as Map<String, dynamic>))
                  .toList(),
          outstandingTelepastoringCount:
              json['outstandingTelepastoringCount'] as int,
        )
          ..id = json['id'] as String
          ..typename = json['typename'] as String
          ..name = json['name'] as String
          ..leader = json['leader'] == null
              ? null
              : MemberForList.fromJson(json['leader'] as Map<String, dynamic>)
          ..admin = json['admin'] == null
              ? null
              : MemberForList.fromJson(json['admin'] as Map<String, dynamic>);

Map<String, dynamic> _$ChurchForCompletedTelepastoringListToJson(
        ChurchForCompletedTelepastoringList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'name': instance.name,
      'leader': instance.leader,
      'admin': instance.admin,
      'outstandingTelepastoringCount': instance.outstandingTelepastoringCount,
      'completedTelepastoring': instance.completedTelepastoring,
    };
