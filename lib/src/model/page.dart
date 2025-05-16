import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'page.g.dart';

@JsonSerializable()
final class Page with EquatableMixin {
  @JsonKey(name: 'per_page')
  final int perPage;

  final String next;

  @JsonKey(name: 'has_more')
  final bool hasMore;

  @JsonKey(name: 'estimated_total')
  final int estimatedTotal;

  const Page({
    required this.perPage,
    required this.next,
    required this.hasMore,
    required this.estimatedTotal,
  });

  factory Page.fromJson(Map<String, dynamic> json) {
    if (json case {'meta': {'pagination': Map pagination}}) {
      json = {...json, ...pagination};
    } else if (json case {'pagination': Map pagination}) {
      json = {...json, ...pagination};
    }
    return _$PageFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PageToJson(this);

  @override
  List<Object?> get props => [perPage, next, hasMore, estimatedTotal];
}
