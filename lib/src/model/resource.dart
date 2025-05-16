import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../utils.dart';
import 'models.dart';

part 'resource.g.dart';

final class Resource<T extends ResourceData> with EquatableMixin {
  final T data;
  final ResourceMeta meta;

  const Resource({required this.data, required this.meta});

  factory Resource.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return Resource(
      data: fromJsonT(json['data'] as Map<String, dynamic>),
      meta: ResourceMeta.fromJson(json['meta'] as Map<String, dynamic>),
    );
  }

  @override
  List<Object?> get props => [data, meta];
}

@JsonSerializable(createFactory: false)
abstract base class ResourceData with EquatableMixin {
  final String id;

  /// Your own structured key-value data.
  @JsonKey(name: 'custom_data')
  final Map<String, dynamic>? customData;

  /// RFC 3339 datetime string of when this entity was created.
  /// Set automatically by Paddle.
  @DateTimeISO8601Converter()
  @JsonKey(name: 'created_at')
  final String createdAt;

  /// RFC 3339 datetime string of when this entity was updated.
  /// Set automatically by Paddle.
  @DateTimeISO8601Converter()
  @JsonKey(name: 'updated_at')
  final String updatedAt;

  /// Import information for this entity. null if this entity is not imported.
  @JsonKey(name: 'import_meta')
  final ImportMeta? importMeta;

  const ResourceData({
    required this.id,
    required this.customData,
    required this.createdAt,
    required this.updatedAt,
    this.importMeta,
  });

  Map<String, dynamic> toJson();

  @override
  List<Object?> get props => [id, customData, createdAt, updatedAt, importMeta];
}

@JsonSerializable()
final class ResourceMeta with EquatableMixin {
  @JsonKey(name: 'request_id')
  final String requestId;

  final Page? pagination;

  const ResourceMeta({required this.requestId, required this.pagination});

  factory ResourceMeta.fromJson(Map<String, dynamic> json) =>
      _$ResourceMetaFromJson(json);

  Map<String, dynamic> toJson() => _$ResourceMetaToJson(this);

  @override
  List<Object?> get props => [pagination];
}

abstract class ResourceList<R extends ResourceData> with EquatableMixin {
  final ResourceMeta meta;

  final List<R> data;

  const ResourceList({required this.meta, required this.data});

  Map<String, dynamic> toJson();

  ResourceList copyWith({ResourceMeta? meta, List<R>? data});

  @override
  List<Object?> get props => [meta, data];
}
