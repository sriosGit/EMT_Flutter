// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Alternative.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Alternative _$AlternativeFromJson(Map<String, dynamic> json) {
  return Alternative(
    json['description'] as String,
    json['value'] as String,
  );
}

Map<String, dynamic> _$AlternativeToJson(Alternative instance) =>
    <String, dynamic>{
      'description': instance.description,
      'value': instance.value,
    };
