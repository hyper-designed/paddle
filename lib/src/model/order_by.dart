import 'package:equatable/equatable.dart';
import 'package:paddle/src/model/sort_direction.dart';

abstract class OrderBy<T> with EquatableMixin {
  final SortDirection direction;
  final T field;

  const OrderBy({required this.direction, required this.field});

  String get fieldParam;

  Map<String, dynamic> toQueryParams() => {
    'order_by': '$fieldParam[${direction.param}]',
  };

  @override
  List<Object?> get props => [direction, field];
}
