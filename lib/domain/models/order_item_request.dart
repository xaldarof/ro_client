class OrderItemRequest {
  final String name;
  final double price;

  const OrderItemRequest({
    required this.name,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'price': this.price,
    };
  }

  factory OrderItemRequest.fromMap(Map<String, dynamic> map) {
    return OrderItemRequest(
      name: map['name'] as String,
      price: map['price'] as double,
    );
  }
}
