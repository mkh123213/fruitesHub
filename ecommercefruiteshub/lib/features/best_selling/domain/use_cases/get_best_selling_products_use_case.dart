import 'package:dartz/dartz.dart';
import 'package:ecommercefruiteshub/core/entities/product_entity.dart';
import 'package:ecommercefruiteshub/core/errors/failures.dart';
import 'package:ecommercefruiteshub/core/repos/products_repo/products_repo.dart';
import 'package:ecommercefruiteshub/features/best_selling/domain/repo_interface/best_selling_repo_interface.dart';

class GetBestSellingProductsUseCase {
  final BestSellingRepoInterface repo;
  GetBestSellingProductsUseCase({required this.repo});
  Future<Either<Failure, List<ProductEntity>>> call() async {
    return repo.getBestSelling();
  }
}
