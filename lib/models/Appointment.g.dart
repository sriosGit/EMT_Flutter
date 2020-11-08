// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Appointment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Appointment _$AppointmentFromJson(Map<String, dynamic> json) {
  return Appointment(
    json['idCita'] as int,
    json['estadoCita'] as String,
    json['nombre'] as String,
    json['description'] as String,
    json['fechaInicio'] as String ?? '13/09/2020',
    json['fechaFin'] as String ?? '13/09/2020',
    json['area'] as String,
    json['descripcion'] as String,
    json['primerNOmbre'] as String,
    json['primerApellido'] as String,
  );
}

Map<String, dynamic> _$AppointmentToJson(Appointment instance) =>
    <String, dynamic>{
      'idCita': instance.idCita,
      'estadoCita': instance.estadoCita,
      'nombre': instance.nombre,
      'description': instance.description,
      'descripcion': instance.descripcion,
      'fechaInicio': instance.fechaInicio,
      'fechaFin': instance.fechaFin,
      'area': instance.area,
      'primerNOmbre': instance.primerNOmbre,
      'primerApellido': instance.primerApellido,
    };
