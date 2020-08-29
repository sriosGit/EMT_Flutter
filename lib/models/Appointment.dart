import 'package:json_annotation/json_annotation.dart';

/// This allows the `Appointment` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part "Appointment.g.dart";

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class Appointment {
  final int id;
  final String status;
  final String description;
  final String date;
  final String area;

  Appointment(this.id, this.status, this.description, this.date, this.area);

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$EvaluationFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Appointment.fromJson(Map<String, dynamic> json) =>
      _$AppointmentFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentToJson(this);
}
