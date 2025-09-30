abstract class CartEvent {}

class AddToCartEvent extends CartEvent {
  int productId;
  int qty;

  AddToCartEvent({required this.productId, required this.qty});
}

class UpdateQtyEvent extends CartEvent {
  int userId;
  int productId;
  int qty;

  UpdateQtyEvent({
    required this.userId,
    required this.productId,
    required this.qty,
  });
}

class DeleteFromCartEvent extends CartEvent {
  int cartId;

  DeleteFromCartEvent({required this.cartId});
}

class FetchCartEvent extends CartEvent {}
