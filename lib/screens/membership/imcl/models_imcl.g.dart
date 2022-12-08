// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models_imcl.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImclForList _$ImclForListFromJson(Map<String, dynamic> json) {
  return ImclForList(
    id: json['id'] as String,
    typename: json['typename'] as String,
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    pictureUrl: json['pictureUrl'] as String,
    status: json['status'] as String?,
    phoneNumber: json['phoneNumber'] as String?,
    whatsappNumber: json['whatsappNumber'] as String?,
    imclChecked: json['imclChecked'] as bool,
    missedChurchComments: (json['missedChurchComments'] as List<dynamic>)
        .map((e) => MissedChurchComment.fromJson(e as Map<String, dynamic>))
        .toList(),
  )..lost = json['lost'] as bool?;
}

Map<String, dynamic> _$ImclForListToJson(ImclForList instance) =>
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
      'imclChecked': instance.imclChecked,
      'missedChurchComments': instance.missedChurchComments,
    };

ChurchForImclList _$ChurchForImclListFromJson(Map<String, dynamic> json) {
  return ChurchForImclList(
    imcls: (json['imcls'] as List<dynamic>)
        .map((e) => ImclForList.fromJson(e as Map<String, dynamic>))
        .toList(),
  )
    ..id = json['id'] as String
    ..typename = json['typename'] as String
    ..name = json['name'] as String
    ..leader = json['leader'] == null
        ? null
        : MemberForList.fromJson(json['leader'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ChurchForImclListToJson(ChurchForImclList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'name': instance.name,
      'leader': instance.leader,
      'imcls': instance.imcls,
    };

PastoralComments _$PastoralCommentsFromJson(Map<String, dynamic> json) {
  return PastoralComments(
    id: json['id'] as String,
    typename: json['typename'] as String,
    timestamp: DateTime.parse(json['timestamp'] as String),
    comment: json['comment'] as String,
    author: MemberForList.fromJson(json['author'] as Map<String, dynamic>),
    activity: json['activity'] as String,
  );
}

Map<String, dynamic> _$PastoralCommentsToJson(PastoralComments instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'timestamp': instance.timestamp.toIso8601String(),
      'comment': instance.comment,
      'activity': instance.activity,
      'author': instance.author,
    };

MissedChurchComment _$MissedChurchCommentFromJson(Map<String, dynamic> json) {
  return MissedChurchComment()
    ..id = json['id'] as String
    ..typename = json['typename'] as String
    ..timestamp = DateTime.parse(json['timestamp'] as String)
    ..comment = json['comment'] as String
    ..activity = json['activity'] as String
    ..author = MemberForList.fromJson(json['author'] as Map<String, dynamic>);
}

Map<String, dynamic> _$MissedChurchCommentToJson(
        MissedChurchComment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typename': instance.typename,
      'timestamp': instance.timestamp.toIso8601String(),
      'comment': instance.comment,
      'activity': instance.activity,
      'author': instance.author,
    };
