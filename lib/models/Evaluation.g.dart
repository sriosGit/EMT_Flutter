// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Evaluation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Evaluation _$EvaluationFromJson(Map<String, dynamic> json) {
  return Evaluation(
    json['idEvaluacion'] as int,
    json['idObjetoEvaluacion'] as int,
    json['idEstudiante'] as int,
    json['contenido'] as String,
    json['descripcion'] as String,
    json['nombreEvaluacion'] as String,
    json['fechaEvaluacion'] as String ?? '19/07/2020',
    json['nombreEspecialista'] as String,
  );
}

Map<String, dynamic> _$EvaluationToJson(Evaluation instance) =>
    <String, dynamic>{
      'idEvaluacion': instance.id,
      'idObjetoEvaluacion': instance.idObjetoEvaluacion,
      'idEstudiante': instance.idEstudiante,
      'contenido': instance.status,
      'nombreEvaluacion': instance.nombreEvaluacion,
      'descripcion': instance.description,
      'fechaEvaluacion': instance.date,
      'nombreEspecialista': instance.tutorName,
    };
