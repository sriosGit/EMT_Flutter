import 'package:json_annotation/json_annotation.dart';

/// This allows the `Alternative` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'PushedNotification.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class PushedNotification {
  final String title;
  final String description;
  final String date;
  PushedNotification(this.title, this.description, this.date);

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$PushedNotificationFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory PushedNotification.fromJson(Map<String, dynamic> json) =>
      _$PushedNotificationFromJson(json);

  Map<String, dynamic> toJson() => _$PushedNotificationToJson(this);
}
