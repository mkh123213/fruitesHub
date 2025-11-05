import 'package:dartz/dartz.dart';
import 'package:ecommercefruiteshub/core/entities/product_entity.dart';
import 'package:ecommercefruiteshub/core/errors/failures.dart';
import 'package:ecommercefruiteshub/features/products/domain/repo_interface/product_repo_interface.dart';

class SearchProductUseCase {
  final ProductRepoInterface repo;

  SearchProductUseCase({required this.repo});

  Stream<Either<Failure, List<ProductEntity>>> call({required String? query}) =>
      repo.searchProduct(query: query);
}
