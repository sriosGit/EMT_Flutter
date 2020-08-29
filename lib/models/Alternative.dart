import 'package:json_annotation/json_annotation.dart';

/// This allows the `Alternative` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'Alternative.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class Alternative {
  final String description;
  final String value;
  Alternative(this.description, this.value);

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$AlternativeFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Alternative.fromJson(Map<String, dynamic> json) =>
      _$AlternativeFromJson(json);

  Map<String, dynamic> toJson() => _$AlternativeToJson(this);
}
