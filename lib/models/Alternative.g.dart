// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Alternative.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Alternative _$AlternativeFromJson(Map<String, dynamic> json) {
  return Alternative(
    json['nombreAlternativa'] as String,
    json['ordenAlternativa'] as int,
  );
}

Map<String, dynamic> _$AlternativeToJson(Alternative instance) =>
    <String, dynamic>{
      'nombreAlternativa': instance.description,
      'ordenAlternativa': instance.value,
    };
