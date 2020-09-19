import 'package:json_annotation/json_annotation.dart';

/// This allows the `Session` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part "Session.g.dart";

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable(explicitToJson: true)
class Session {
  final int idEstudiante;
  final String token;

  Session(this.idEstudiante, this.token);

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$SessionFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);

  Map<String, dynamic> toJson() => _$SessionToJson(this);
}
