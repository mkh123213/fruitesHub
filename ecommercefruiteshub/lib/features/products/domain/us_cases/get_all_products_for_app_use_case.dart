import 'package:dartz/dartz.dart';
import 'package:ecommercefruiteshub/core/entities/product_entity.dart';
import 'package:ecommercefruiteshub/core/errors/failures.dart';
import 'package:ecommercefruiteshub/features/products/domain/repo_interface/product_repo_interface.dart';

class GetAllProductsForAppUseCase {
  final ProductRepoInterface repo;

  GetAllProductsForAppUseCase({required this.repo});

  Future<Either<Failure, List<ProductEntity>>> call() => repo.getProducts();
}
