// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) {
  return Profile(
    id: json['id'] as String,
    role: json['role'] as String,
    location: json['location'] as String,
  );
}

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'id': instance.id,
      'role': instance.role,
      'location': instance.location,
    };
