import 'package:flutter/material.dart';

import '../../domain/models/order_item_request.dart';

final List<OrderItemRequest> _foods = [
  OrderItemRequest(name: 'Osh', price: 12000, count: 1),
  OrderItemRequest(name: 'Qazi', price: 15000, count: 1),
  OrderItemRequest(name: 'Shashlik', price: 20000, count: 1),
];

class AddOrderToTableDialogContent extends StatelessWidget {
  final Function(OrderItemRequest food) onSelect;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (e, i) {
        final food = _foods[i];
        return ListTile(
          onTap: () {
            onSelect.call(food);
            Navigator.pop(context);
          },
          title: Text(food.name),
          subtitle: Text(food.name),
          trailing: Text(food.price.toString()),
        );
      },
      itemCount: _foods.length,
    );
  }

  const AddOrderToTableDialogContent({
    super.key,
    required this.onSelect,
  });
}
