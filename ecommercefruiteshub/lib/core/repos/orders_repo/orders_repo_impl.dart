// // import 'package:dartz/dartz.dart';
// // import 'package:fruits_hub/core/errors/failures.dart';
// // import 'package:fruits_hub/core/repos/orders_repo/orders_repo.dart';
// // import 'package:fruits_hub/core/services/data_service.dart';
// // import 'package:fruits_hub/core/services/firestore_service.dart';
// // import 'package:fruits_hub/core/utils/backend_endpoint.dart';
// // import 'package:fruits_hub/features/checkout/data/models/order_model.dart';
// // import 'package:fruits_hub/features/checkout/domain/entites/order_entity.dart';

// // import '../../services/get_it_service.dart';

// // class OrdersRepoImpl implements OrdersRepo {
// //   final DatabaseService dataBaseService;

// //   OrdersRepoImpl(this.dataBaseService);
// //   @override
// //   Future<Either<Failure, void>> addOrder(
// //       {required OrderInputEntity order}) async {
// //     try {
// //       var orderModel = OrderModel.fromEntity(order);
// //       await dataBaseService.addData(
// //         path: BackendEndpoint.addOrder,
// //         documentId: orderModel.orderId,
// //         data: orderModel.toJson(),
// //       );
// //       return const Right(null);
// //     } catch (e) {
// //       return Left(ServerFailure(e.toString()));
// //     }
// //   }
// // }
// import 'package:dartz/dartz.dart';
// import 'package:ecommercefruiteshub/core/errors/exceptions.dart';
// import 'package:ecommercefruiteshub/core/errors/failures.dart';
// import 'package:ecommercefruiteshub/core/repos/orders_repo/orders_repo_interface.dart';
// import 'package:ecommercefruiteshub/features/check_out/data/data_source/chech_out_remote_data_source.dart';
// import 'package:ecommercefruiteshub/core/entities/order_entity.dart';
// import 'package:ecommercefruiteshub/features/profile/domain/entities/order_track_entity.dart';
// import 'package:ecommercefruiteshub/features/check_out/domain/repo_interface/order_repo_interface.dart';

// class OrderRepoImpl implements OrderRepoInterface {
//   final CheckOutRemoteDataSource repo;

//   OrderRepoImpl({required this.repo});
//   @override
//   Future<Either<Failure, void>> addOrder({
//     required OrderInputEntity order,
//   }) async {
//     try {
//       await repo.addOrder(order: order);
//       return const Right(null);
//     } on CustomException catch (e) {
//       return Left(ServerFailure(e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, List<OrderTrack>>> getOrderTrack() async {
//     try {
//       final ordeerTrack = await repo.getOrderTrack();
//       return Right(ordeerTrack);
//     } on CustomException catch (e) {
//       return Left(ServerFailure(e.toString()));
//     }
//   }
// }
