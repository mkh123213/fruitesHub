// import 'package:dartz/dartz.dart';
// import 'package:ecommercefruiteshub/core/entities/product_entity.dart';
// import 'package:ecommercefruiteshub/core/errors/failures.dart';
// import 'package:ecommercefruiteshub/core/models/product_model.dart';
// import 'package:ecommercefruiteshub/core/repos/products_repo/products_repo.dart';
// import 'package:ecommercefruiteshub/core/services/firestore_service.dart';
// import 'package:ecommercefruiteshub/core/utils/api_path.dart';

// class ProductsRepoImpl extends ProductsRepo {
//   final DataBaseService databaseService;
//   //
//   ProductsRepoImpl(this.databaseService);
//   @override
//   Future<Either<Failure, List<ProductEntity>>> getBestSellingProducts() async {
//     try {
//       var data = await databaseService.getCollection(
//         path: ApiPath.products(),

//         // query: {
//         //   'limit': 10,
//         //   'orderBy': 'sellingCount',
//         //   'descending': true
//         // }
//         queryBuilder: (query) {
//           return query.limit(5).orderBy('sellingCount', descending: true);
//         },

//         builder: (query, documentId) => ProductModel.fromJson(query).toEntity(),
//         // builder: (data, documentId) {
//         //   print(data);
//         //   return ProductModel.fromJson(data).toEntity();
//         // },
//       );

//       // List<ProductEntity> products =
//       //     data.map((e) => ProductModel.fromJson(e).toEntity()).toList();
//       return right(data);
//     } catch (e) {
//       return left(ServerFailure('Failed to get products'));
//     }
//   }

//   // @override
//   // Future<Either<Failure, List<ProductEntity>>> getProducts() async {
//   //   try {
//   //     var data = await databaseService.getData(
//   //         path: BackendEndpoint.getProducts) as List<Map<String, dynamic>>;

//   //     List<ProductEntity> products =
//   //         data.map((e) => ProductModel.fromJson(e).toEntity()).toList();
//   //     return right(products);
//   //   } catch (e) {
//   //     return left(ServerFailure('Failed to get products'));
//   //   }
//   // }
// }
