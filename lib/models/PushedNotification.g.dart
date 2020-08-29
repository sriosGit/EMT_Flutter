// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PushedNotification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PushedNotification _$PushedNotificationFromJson(Map<String, dynamic> json) {
  return PushedNotification(
    json['title'] as String,
    json['description'] as String,
    json['date'] as String,
  );
}

Map<String, dynamic> _$PushedNotificationToJson(PushedNotification instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'date': instance.date,
    };
