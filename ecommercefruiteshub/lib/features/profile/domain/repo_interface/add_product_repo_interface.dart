import 'package:dartz/dartz.dart';
import 'package:ecommercefruiteshub/core/entities/product_entity.dart';
import 'package:ecommercefruiteshub/core/errors/failures.dart';

abstract class AddProductRepoInterface {
  Future<Either<Failure, void>> addProduct({required ProductEntity product});
}
