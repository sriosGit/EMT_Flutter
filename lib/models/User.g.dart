// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['nombreEstudiante'] as String,
    json['apellidos'] as String,
    json['colegio'] as String,
    json['section'] as String,
    json['tutor'] as String,
    json['correoEstudiante'] as String,
    json['picture'] as String,
    json['dniEstudiante'] as int,
    json['celularEstudiante'] as int,
    json['nombrePadre'] as String,
    json['estApellidoPaterno'] as String,
    json['estApellidoMaterno'] as String,
    json['celularPadre'] as int,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'nombreEstudiante': instance.firstName,
      'apellidos': instance.lastName,
      'colegio': instance.colegio,
      'section': instance.section,
      'tutor': instance.tutor,
      'correoEstudiante': instance.email,
      'picture': instance.picture,
      'dniEstudiante': instance.dniEstudiante,
      'celularEstudiante': instance.celularEstudiante,
      'nombrePadre': instance.nombrePadre,
      'estApellidoPaterno': instance.apellidoPadre,
      'estApellidoMaterno': instance.apellidoMadre,
      'celularPadre': instance.celularPadre,
    };
