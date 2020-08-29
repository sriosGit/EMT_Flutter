// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) {
  return Question(
    json['title'] as String,
    json['body'] as String,
    json['type'] as String,
    (json['alternatives'] as List)
        ?.map((e) =>
            e == null ? null : Alternative.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['answer'] as String ?? '',
    json['btnText'] as String ?? 'Siguiente',
  );
}

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
      'type': instance.type,
      'alternatives': instance.alternatives?.map((e) => e?.toJson())?.toList(),
      'answer': instance.answer,
      'btnText': instance.btnText,
    };
