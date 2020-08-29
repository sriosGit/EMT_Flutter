import 'package:json_annotation/json_annotation.dart';

/// This allows the `Activity` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'Activity.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class Activity {
  final String action;
  Activity(this.action);

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$ActivityFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityToJson(this);
}
