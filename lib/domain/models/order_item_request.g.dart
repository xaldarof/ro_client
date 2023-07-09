// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderTable _$OrderTableFromJson(Map<String, dynamic> json) => OrderTable(
      tableNumber: json['tableNumber'] as int,
      orders: (json['orders'] as List<dynamic>)
          .map((e) => OrderItemRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderTableToJson(OrderTable instance) =>
    <String, dynamic>{
      'tableNumber': instance.tableNumber,
      'orders': instance.orders,
    };

OrderItemRequest _$OrderItemRequestFromJson(Map<String, dynamic> json) =>
    OrderItemRequest(
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      count: json['count'] as int,
    );

Map<String, dynamic> _$OrderItemRequestToJson(OrderItemRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
      'count': instance.count,
    };
