import 'package:dartz/dartz.dart';
import 'package:ecommercefruiteshub/core/errors/exceptions.dart';
import 'package:ecommercefruiteshub/core/errors/failures.dart';
import 'package:ecommercefruiteshub/core/entities/order_entity.dart';
import 'package:ecommercefruiteshub/features/check_out/data/data_source/chech_out_remote_data_source.dart';
import 'package:ecommercefruiteshub/features/check_out/domain/repo_interface/order_repo_interface.dart';
import 'package:ecommercefruiteshub/features/profile/domain/entities/order_track_entity.dart';

class CheckOutRepoImpl implements CheckOutRepoInterface {
  final CheckOutRemoteDataSource checkOutRemoteDataSource;

  CheckOutRepoImpl({required this.checkOutRemoteDataSource});
  @override
  Future<Either<Failure, void>> addOrder({
    required OrderInputEntity order,
  }) async {
    try {
      await checkOutRemoteDataSource.addOrder(order: order);
      return const Right(null);
    } on CustomException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
