// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Evaluation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Evaluation _$EvaluationFromJson(Map<String, dynamic> json) {
  return Evaluation(
    json['id'] as int,
    json['contenido'] as String,
    json['descripcion'] as String,
    json['fechaEvaluacion'] as String ?? '19/07/2020',
    json['nombreEspecialista'] as String,
  );
}

Map<String, dynamic> _$EvaluationToJson(Evaluation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'contenido': instance.status,
      'descripcion': instance.description,
      'fechaEvaluacion': instance.date,
      'nombreEspecialista': instance.tutorName,
    };
