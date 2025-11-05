import 'package:dartz/dartz.dart';
import 'package:ecommercefruiteshub/core/errors/failures.dart';
import 'package:ecommercefruiteshub/features/profile/data/repo_impl/main_profile_repo_impl.dart';
import 'package:ecommercefruiteshub/features/profile/domain/entities/order_track_entity.dart';

class GetOrdersTrackUseCase {
  final MainProfileRepoImpl repo;
  GetOrdersTrackUseCase({required this.repo});

  Future<Either<Failure, List<OrderTrack>>> call() {
    return repo.getOrderTrack();
  }
}
