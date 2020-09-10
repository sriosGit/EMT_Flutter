import 'package:EMT/models/Alternative.dart';
import 'package:json_annotation/json_annotation.dart';

/// This allows the `Question` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part "Question.g.dart";

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable(explicitToJson: true)
class Question {
  @JsonKey(name: "nombrePregunta")
  final String title;
  final String body;

  @JsonKey(defaultValue: "radio")
  final String type;

  @JsonKey(name: "alternativa")
  final List<Alternative> alternatives;

  @JsonKey(defaultValue: "")
  final String answer;

  @JsonKey(defaultValue: "Siguiente")
  final String btnText;

  Question(this.title, this.body, this.type, this.alternatives, this.answer,
      this.btnText);

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$QuestionFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}
