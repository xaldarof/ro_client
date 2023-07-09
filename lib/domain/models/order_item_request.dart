import 'package:json_annotation/json_annotation.dart';

part 'order_item_request.g.dart';

@JsonSerializable()
class OrderTable {
  final int tableNumber;
  final List<OrderItemRequest> orders;

  const OrderTable({
    required this.tableNumber,
    required this.orders,
  });

  @override
  String toString() {
    return 'OrderTable{tableNumber: $tableNumber, orders: $orders}';
  }

  factory OrderTable.fromJson(Map<String, dynamic> json) =>
      _$OrderTableFromJson(json);

  Map<String, dynamic> toJson() => _$OrderTableToJson(this);

  OrderTable copyWith({
    int? tableNumber,
    List<OrderItemRequest>? orders,
  }) {
    return OrderTable(
      tableNumber: tableNumber ?? this.tableNumber,
      orders: orders ?? this.orders,
    );
  }
}

@JsonSerializable()
class OrderItemRequest {
  final String name;
  final double price;
  int count;

  OrderItemRequest({
    required this.name,
    required this.price,
    required this.count,
  });

  void increaseCount({int size = 1}) {
    count += size;
  }

  void decreaseCount({int size = 1}) {
    if (count > 0) count -= size;
  }

  @override
  String toString() {
    return 'OrderItemRequest{name: $name, price: $price}';
  }

  Map<String, dynamic> toJson() => _$OrderItemRequestToJson(this);

  factory OrderItemRequest.fromJson(Map<String, dynamic> json) =>
      _$OrderItemRequestFromJson(json);

  OrderItemRequest copyWith({
    String? name,
    double? price,
    int? count,
  }) {
    return OrderItemRequest(
      name: name ?? this.name,
      price: price ?? this.price,
      count: count ?? this.count,
    );
  }
}
