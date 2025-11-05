part of 'products_cubit.dart';

sealed class ProductsState {}

final class ProductsInitial extends ProductsState {}

final class BestSellingLoading extends ProductsState {}

final class BestSellingFailure extends ProductsState {
  final String errMessage;
  BestSellingFailure({required this.errMessage});
}

final class BestSellingLoaded extends ProductsState {
  final List<ProductEntity> products;
  BestSellingLoaded({required this.products});
}

final class AllProductsLoading extends ProductsState {}

final class AllProductsLoaded extends ProductsState {
  final List<ProductEntity> products;
  AllProductsLoaded({required this.products});
}

final class AllProductsFailure extends ProductsState {
  final String message;
  AllProductsFailure({required this.message});
}

final class AllProductsForAppLoading extends ProductsState {}

final class AllProductsForAppLoaded extends ProductsState {
  final List<ProductEntity> products;
  AllProductsForAppLoaded({required this.products});
}

final class AllProductsForAppFailure extends ProductsState {
  final String message;
  AllProductsForAppFailure({required this.message});
}

final class SearchProductsLoading extends ProductsState {}

final class SearchProductsEmpty extends ProductsState {}

final class SearchProductsLoaded extends ProductsState {
  final List<ProductEntity> products;
  SearchProductsLoaded({required this.products});
}

final class SearchProductsFailure extends ProductsState {
  final String message;
  SearchProductsFailure({required this.message});
}
