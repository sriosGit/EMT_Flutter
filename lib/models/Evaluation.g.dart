// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Evaluation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Evaluation _$EvaluationFromJson(Map<String, dynamic> json) {
  return Evaluation(
    json['id'] as int,
    json['status'] as String,
    json['description'] as String,
    json['date'] as String,
    json['tutorName'] as String,
  );
}

Map<String, dynamic> _$EvaluationToJson(Evaluation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'description': instance.description,
      'date': instance.date,
      'tutorName': instance.tutorName,
    };
