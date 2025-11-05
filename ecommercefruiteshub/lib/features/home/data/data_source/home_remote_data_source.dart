import 'package:ecommercefruiteshub/core/connection/network_info.dart';
import 'package:ecommercefruiteshub/core/entities/product_entity.dart';
import 'package:ecommercefruiteshub/core/errors/exceptions.dart';
import 'package:ecommercefruiteshub/core/models/product_model.dart';
import 'package:ecommercefruiteshub/core/services/firestore_service.dart';
import 'package:ecommercefruiteshub/core/utils/api_path.dart';

class HomeRemoteDataSource {
  final DataBaseService dataBaseService;
  final NetworkInfo networkInfo;
  HomeRemoteDataSource({
    required this.dataBaseService,
    required this.networkInfo,
  });

  Future<List<ProductEntity>> getAllProducts() async {
    if (await networkInfo.isConnected == true) {
      try {
        final allProductsList = await dataBaseService.getCollection(
          path: ApiPath.products(),
          builder: (query, documentId) =>
              ProductModel.fromJson(query).toEntity(),
        );

        return allProductsList;
      } catch (e) {
        throw CustomException(
          message:
              'Exeption in getAllProducts : Failed to get products from fierbase',
        );
      }
    } else {
      throw CustomException(message: 'No internet connection');
    }
  }
}
