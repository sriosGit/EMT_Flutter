// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) {
  return Question(
    json['idPregunta'] as int,
    json['nombrePregunta'] as String,
    json['body'] as String,
    json['type'] as String ?? 'radio',
    (json['alternativa'] as List)
        ?.map((e) =>
            e == null ? null : Alternative.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['answer'] as String ?? '',
    json['btnText'] as String ?? 'Siguiente',
  );
}

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'idPregunta': instance.id,
      'nombrePregunta': instance.title,
      'body': instance.body,
      'type': instance.type,
      'alternativa': instance.alternatives?.map((e) => e?.toJson())?.toList(),
      'answer': instance.answer,
      'btnText': instance.btnText,
    };
