import 'package:json_annotation/json_annotation.dart';

/// This allows the `Evaluation` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part "Evaluation.g.dart";

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class Evaluation {
  @JsonKey(name: 'idEvaluacion')
  final int id;

  final int idObjetoEvaluacion;
  final int idEstudiante;
  @JsonKey(name: 'contenido')
  final String status;

  final String nombreEvaluacion;

  @JsonKey(name: 'descripcion')
  final String description;

  @JsonKey(name: 'fechaEvaluacion', defaultValue: '19/07/2020')
  final String date;

  @JsonKey(name: 'nombreEspecialista')
  final String tutorName;

  Evaluation(this.id, this.idObjetoEvaluacion, this.idEstudiante, this.status,
      this.description, this.nombreEvaluacion, this.date, this.tutorName);

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$EvaluationFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Evaluation.fromJson(Map<String, dynamic> json) =>
      _$EvaluationFromJson(json);

  Map<String, dynamic> toJson() => _$EvaluationToJson(this);
}
