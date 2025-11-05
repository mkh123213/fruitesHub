import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommercefruiteshub/core/entities/product_entity.dart';
import 'package:ecommercefruiteshub/core/errors/failures.dart';
import 'package:ecommercefruiteshub/features/best_selling/domain/use_cases/get_best_selling_products_use_case.dart';
import 'package:ecommercefruiteshub/features/home/domain/use_cases/get_all_products_use_cse.dart';
import 'package:ecommercefruiteshub/features/products/domain/us_cases/get_all_products_for_app_use_case.dart';
import 'package:ecommercefruiteshub/features/products/domain/us_cases/search_product_use_case.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit({
    required this.searchProductUseCase,
    required this.getAllProductsForAppUseCase,
    required this.getBestSellingProductsUseCase,
    required this.getAllProductsUseCse,
  }) : super(ProductsInitial());
  final GetBestSellingProductsUseCase getBestSellingProductsUseCase;
  final GetAllProductsUseCse getAllProductsUseCse;
  final GetAllProductsForAppUseCase getAllProductsForAppUseCase;
  final SearchProductUseCase searchProductUseCase;
  StreamSubscription<Either<Failure, List<ProductEntity>>>? subscription;

  // int productsLength = 0;
  // Future<void> getProducts() async {
  //   emit(ProductsLoading());
  //   final result = await productsRepo.getProducts();
  //   result.fold(
  //     (failure) => emit(ProductsFailure(failure.message)),
  //     (products) => emit(ProductsSuccess(products)),
  //   );
  // }

  // Future<void> getBestSellingroducts() async {
  //   emit(ProductsLoading());
  //   final result = await productsRepo.getBestSellingProducts();
  //   result.fold(
  //     (failure) => emit(ProductsFailure(failure.message)),
  //     (products) {
  //       productsLength = products.length;
  //       emit(ProductsSuccess(products));
  //     },searchController
  //   );
  // }

  int productsLength = 0;
  TextEditingController searchController = TextEditingController();
  Future<void> getBestSellingProducts() async {
    emit(BestSellingLoading());
    final result = await getBestSellingProductsUseCase.call();
    result.fold(
      (failure) => emit(BestSellingFailure(errMessage: failure.message)),
      (products) => emit(BestSellingLoaded(products: products)),
    );
  }

  Future<void> getAllProducts() async {
    emit(AllProductsLoading());
    final result = await getAllProductsUseCse();
    result.fold(
      (failure) => emit(AllProductsFailure(message: failure.message)),
      (products) => emit(AllProductsLoaded(products: products)),
    );
  }

  Future<void> getAllProductsForApp() async {
    emit(AllProductsForAppLoading());
    final result = await getAllProductsForAppUseCase.call();
    result.fold(
      (failure) => emit(AllProductsForAppFailure(message: failure.message)),
      (products) {
        productsLength = products.length;
        emit(AllProductsForAppLoaded(products: products));
      },
    );
  }

  void searchProduct({required String? query}) {
    emit(SearchProductsLoading());
    subscription = searchProductUseCase.call(query: query).listen((
      subscription,
    ) {
      subscription.fold(
        (failure) => emit(SearchProductsFailure(message: failure.message)),
        (products) {
          productsLength = products.length;
          emit(SearchProductsLoaded(products: products));
          if (products.isEmpty) {
            emit(SearchProductsEmpty());
          }
          disposeSearchStream();
        },
      );
    });
  }

  /*************  ✨ Windsurf Command ⭐  *************/
  /// Cancel the stream subscription.
  ///
  /// This method is called when the widget is about to be disposed.
  /// It is used to cancel the subscription to the stream of products returned by the searchProductUseCase.
  ///
  /// The subscription is cancelled to prevent memory leaks.
  /*******  c6b83a2f-8b4c-4a07-a825-abaf7482e8e8  *******/
  void disposeSearchStream() {
    print("dispose");
    subscription?.cancel(); // Cancel the stream subscription
    subscription?.cancel();
  }
}
