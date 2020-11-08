// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'JournalEntry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JournalEntry _$JournalEntryFromJson(Map<String, dynamic> json) {
  return JournalEntry(
    json['texto'] as String ?? 'Nombre',
    json['resultado'] as String ?? 'Sin resultado',
  );
}

Map<String, dynamic> _$JournalEntryToJson(JournalEntry instance) =>
    <String, dynamic>{
      'texto': instance.texto,
      'resultado': instance.resultado,
    };
