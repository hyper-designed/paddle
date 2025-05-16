import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'import_meta.g.dart';

enum ImportedFrom {
  @JsonValue('paddle_classic')
  paddleClassic,
}

/// Import information for an entity
@JsonSerializable()
final class ImportMeta with EquatableMixin {
  /// Name of the platform or provider where this entity was imported from.
  @JsonKey(name: 'imported_from')
  final ImportedFrom importedFrom;

  /// Reference or identifier for this entity from the provider
  /// where it was imported from.
  @JsonKey(name: 'external_id')
  final String? externalId;

  const ImportMeta({required this.importedFrom, this.externalId});

  factory ImportMeta.fromJson(Map<String, dynamic> json) =>
      _$ImportMetaFromJson(json);

  Map<String, dynamic> toJson() => _$ImportMetaToJson(this);

  @override
  List<Object?> get props => [importedFrom, externalId];
}
