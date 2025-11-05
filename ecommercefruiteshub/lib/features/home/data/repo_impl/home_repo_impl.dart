import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:ecommercefruiteshub/core/entities/product_entity.dart';
import 'package:ecommercefruiteshub/core/errors/exceptions.dart';
import 'package:ecommercefruiteshub/core/errors/failures.dart';
import 'package:ecommercefruiteshub/features/home/data/data_source/home_remote_data_source.dart';
import 'package:ecommercefruiteshub/features/home/domain/home_repo_interface/home_repo_interface.dart';

class HomeRepoImpl implements HomeRepoInterface {
  final HomeRemoteDataSource homeDataSource;
  HomeRepoImpl({required this.homeDataSource});
  @override
  Future<Either<Failure, List<ProductEntity>>> getHomeProducts() async {
    try {
      final result = await homeDataSource.getAllProducts();
      return Right(result);
    } on CustomException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
