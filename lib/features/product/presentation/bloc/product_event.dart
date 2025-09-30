abstract class ProductEvent {}

class FetchProductEvent extends ProductEvent {
  String categoryId;
  FetchProductEvent({required this.categoryId});
}
