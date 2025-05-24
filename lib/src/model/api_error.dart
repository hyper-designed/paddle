import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_error.g.dart';

enum PaddleErrorType {
  @JsonValue('request_error')
  requestError,
  @JsonValue('validation_error')
  apiError,
}

@JsonSerializable()
class PaddleError extends Error with EquatableMixin {
  final String type;
  final String code;
  final String detail;
  @JsonKey(name: 'documentation_url')
  final String documentationUrl;

  final List<Map<String, String>>? errors;

  PaddleError({
    required this.type,
    required this.code,
    required this.detail,
    required this.documentationUrl,
    this.errors,
  });

  factory PaddleError.fromJson(Map<String, dynamic> json) =>
      _$PaddleErrorFromJson(json);

  Map<String, dynamic> toJson() => _$PaddleErrorToJson(this);

  @override
  List<Object?> get props => [type, code, detail, documentationUrl, errors];
}

@JsonSerializable()
class PaddleApiError extends Error with EquatableMixin {
  final PaddleError error;
  final Map<String, dynamic>? meta;

  PaddleApiError({required this.error, this.meta});

  factory PaddleApiError.fromJson(Map<String, dynamic> json) =>
      _$PaddleApiErrorFromJson(json);

  Map<String, dynamic> toJson() => _$PaddleApiErrorToJson(this);

  @override
  List<Object?> get props => [error, meta];
}
