import 'package:json_annotation/json_annotation.dart';

/// This allows the `Activity` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'JournalEntry.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class JournalEntry {
  @JsonKey(defaultValue: 'Nombre')
  final String texto;

  @JsonKey(defaultValue: 'Sin resultado')
  final String resultado;
  JournalEntry(this.texto, this.resultado);

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$ActivityFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory JournalEntry.fromJson(Map<String, dynamic> json) =>
      _$JournalEntryFromJson(json);

  Map<String, dynamic> toJson() => _$JournalEntryToJson(this);
}
