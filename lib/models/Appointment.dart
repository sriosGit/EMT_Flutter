import 'package:json_annotation/json_annotation.dart';

/// This allows the `Appointment` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part "Appointment.g.dart";

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class Appointment {
  final int idCita;
  final String estadoCita;

  final String nombre;

  final String description;

  @JsonKey(defaultValue: "13/09/2020")
  final String fechaInicio;
  @JsonKey(defaultValue: "13/09/2020")
  final String fechaFin;
  final String area;
  final String primerNOmbre;
  final String primerApellido;
  Appointment(
      this.idCita,
      this.estadoCita,
      this.nombre,
      this.description,
      this.fechaInicio,
      this.fechaFin,
      this.area,
      this.primerNOmbre,
      this.primerApellido);

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$EvaluationFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Appointment.fromJson(Map<String, dynamic> json) =>
      _$AppointmentFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentToJson(this);
}
