import 'package:dartz/dartz.dart';
import 'package:ecommercefruiteshub/core/entities/product_entity.dart';
import 'package:ecommercefruiteshub/core/errors/failures.dart';
import 'package:ecommercefruiteshub/features/home/domain/home_repo_interface/home_repo_interface.dart';

class GetAllProductsUseCse {
  final HomeRepoInterface repo;

  GetAllProductsUseCse({required this.repo});

  Future<Either<Failure, List<ProductEntity>>> call() => repo.getHomeProducts();
}
