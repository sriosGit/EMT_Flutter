// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['firstName'] as String,
    json['lastName'] as String,
    json['schoolName'] as String,
    json['section'] as String,
    json['tutor'] as String,
    json['email'] as String,
    json['picture'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'schoolName': instance.schoolName,
      'section': instance.section,
      'tutor': instance.tutor,
      'email': instance.email,
      'picture': instance.picture,
    };
