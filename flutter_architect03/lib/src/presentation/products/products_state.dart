abstract class ProductsState {

  final String searchTerm;

  ProductsState(this.searchTerm);

  factory ProductsState.loading({required String searchTerm}) => LoadingProductsState(searchTerm: searchTerm);

  factory ProductsState.loaded(String searchTerm,
      List<ProductItemState> products) =>
      LoadedProductsState(searchTerm: searchTerm, products: products);

  factory ProductsState.error(String searchTerm,
      String message) => ErrorProductsState(searchTerm: searchTerm,message: message);
}

class LoadingProductsState extends ProductsState {
  LoadingProductsState({ required String searchTerm }) : super(searchTerm);
}

class LoadedProductsState extends ProductsState {
  final List<ProductItemState> products;

  LoadedProductsState({required this.products, required String searchTerm}): super(searchTerm);
}

class ErrorProductsState<T> extends ProductsState {
  final String message;

  ErrorProductsState({
    required String searchTerm,
    required this.message
  }): super(searchTerm);
}

class ProductItemState {

  final String id;
  final String image;
  final String title;
  final String price;

  ProductItemState(this.id, this.image, this.title, this.price);


}