import 'package:dartz/dartz.dart';
import 'package:ecommercefruiteshub/core/entities/product_entity.dart';
import 'package:ecommercefruiteshub/core/errors/exceptions.dart';
import 'package:ecommercefruiteshub/core/errors/failures.dart';
import 'package:ecommercefruiteshub/features/best_selling/data/data_source/best_selling_remote_data_source.dart';
import 'package:ecommercefruiteshub/features/best_selling/domain/repo_interface/best_selling_repo_interface.dart';

class BestSellingRepoImpl implements BestSellingRepoInterface {
  final BestSellingRemoteDataSource bestSellingRemoteDataSource;

  BestSellingRepoImpl({required this.bestSellingRemoteDataSource});
  @override
  Future<Either<Failure, List<ProductEntity>>> getBestSelling() async {
    try {
      final productsList = await bestSellingRemoteDataSource
          .getBestSellingProducts();
      return right(productsList);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    }
  }
}
