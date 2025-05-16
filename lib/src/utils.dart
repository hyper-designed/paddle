import 'package:json_annotation/json_annotation.dart';

/// Converts [DateTime] to and from ISO 8601 [String].
class DateTimeISO8601Converter extends JsonConverter<DateTime, String> {
  /// Creates a new instance of [DateTimeISO8601Converter].
  const DateTimeISO8601Converter();

  @override
  DateTime fromJson(String json) => deserialize(json);

  @override
  String toJson(DateTime object) => serialize(object);

  /// Serializes [DateTime] to [int].
  static String serialize(DateTime object) => object.toIso8601String();

  /// Deserializes [int] to [DateTime].
  static DateTime deserialize(String value) => DateTime.parse(value);
}

/// Converts [DateTime]? to and from ISO 8601 [String]?.
class DateTimeISO8601NullableConverter
    extends JsonConverter<DateTime?, String?> {
  /// Creates a new instance of [DateTimeISO8601NullableConverter].
  const DateTimeISO8601NullableConverter();

  @override
  DateTime? fromJson(String? json) => deserialize(json);

  @override
  String? toJson(DateTime? object) => serialize(object);

  /// Serializes [DateTime] to [int].
  static String? serialize(DateTime? object) => object?.toIso8601String();

  /// Deserializes [int] to [DateTime].
  static DateTime? deserialize(String? json) {
    return json != null ? DateTime.parse(json) : null;
  }
}

typedef JsonMap = Map<String, dynamic>;

extension EnumIterableExt<T extends Enum> on Iterable<T> {
  T? byNameOrNull(String? name) {
    for (final T value in this) {
      if (value.name == name) return value;
    }
    return null;
  }
}

/// converts a json object to a string
Object? convertToString(Map json, String key) {
  final Object? value = json[key];
  if (value is String) return value;
  if (value is num) return value.toString();
  return null;
}
