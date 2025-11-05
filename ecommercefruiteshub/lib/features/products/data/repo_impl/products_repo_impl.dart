import 'package:dartz/dartz.dart';
import 'package:ecommercefruiteshub/core/entities/product_entity.dart';
import 'package:ecommercefruiteshub/core/errors/exceptions.dart';
import 'package:ecommercefruiteshub/core/errors/failures.dart';
import 'package:ecommercefruiteshub/features/products/data/data_source/product_remote_data_source.dart';
import 'package:ecommercefruiteshub/features/products/domain/repo_interface/product_repo_interface.dart';

class ProductsRepoImpl implements ProductRepoInterface {
  final ProductRemoteDataSource productsRemoteDatqaSource;
  ProductsRepoImpl({required this.productsRemoteDatqaSource});
  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    try {
      final productsList = await productsRemoteDatqaSource.getProducts();
      return right(productsList);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    }
  }

  @override
  Stream<Either<Failure, List<ProductEntity>>> searchProduct({
    required String? query,
  }) async* {
    try {
      await for (final productsList in productsRemoteDatqaSource.searchProducts(
        searchLetters: query,
      )) {
        yield right(productsList);
      }
      // yield* productsRemoteDatqaSource.searchProducts(searchLetters: query);
    } on CustomException catch (e) {
      yield left(ServerFailure(e.message));
    }
  }
}
