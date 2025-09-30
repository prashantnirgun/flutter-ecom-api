abstract class OrderEvent {}

class CreateOrderEvent extends OrderEvent {
  int userId;
  int productId;
  int status;

  CreateOrderEvent({
    required this.userId,
    required this.productId,
    required this.status,
  });
}

class FetchOrderEvent extends OrderEvent {}
