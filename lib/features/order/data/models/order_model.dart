class OrderResponse {
  final bool status;
  final String message;
  final List<Order> orders;

  const OrderResponse({
    required this.status,
    required this.message,
    required this.orders,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      orders: (json['orders'] as List<dynamic>? ?? [])
          .map((e) => Order.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'orders': orders.map((e) => e.toJson()).toList(),
    };
  }
}

class Order {
  final int id;
  final String totalAmount;
  final String orderNumber;
  final String status;
  final String createdAt;
  final List<Product> products;

  const Order({
    required this.id,
    required this.totalAmount,
    required this.orderNumber,
    required this.status,
    required this.createdAt,
    required this.products,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] ?? 0,
      totalAmount: json['total_amount'] ?? '0',
      orderNumber: json['order_number'] ?? '',
      status: json['status'] ?? '',
      createdAt: json['created_at'] ?? '',
      products: (json['product'] as List<dynamic>? ?? [])
          .map((e) => Product.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'total_amount': totalAmount,
      'order_number': orderNumber,
      'status': status,
      'created_at': createdAt,
      'product': products.map((e) => e.toJson()).toList(),
    };
  }
}

class Product {
  final int id;
  final String name;
  final int quantity;
  final String price;
  final String image;

  const Product({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      quantity: json['quantity'] ?? 0,
      price: json['price'] ?? '0',
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'price': price,
      'image': image,
    };
  }
}
