// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Appointment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Appointment _$AppointmentFromJson(Map<String, dynamic> json) {
  return Appointment(
    json['id'] as int,
    json['status'] as String,
    json['description'] as String,
    json['date'] as String,
    json['area'] as String,
  );
}

Map<String, dynamic> _$AppointmentToJson(Appointment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'description': instance.description,
      'date': instance.date,
      'area': instance.area,
    };
