import 'package:ecommercefruiteshub/core/connection/network_info.dart';
import 'package:ecommercefruiteshub/core/errors/exceptions.dart';
import 'package:ecommercefruiteshub/core/helper_functions/get_user.dart';
import 'package:ecommercefruiteshub/core/services/firestore_service.dart';
import 'package:ecommercefruiteshub/core/utils/api_path.dart';
import 'package:ecommercefruiteshub/core/models/order_model.dart';
import 'package:ecommercefruiteshub/core/entities/order_entity.dart';
import 'package:ecommercefruiteshub/features/profile/domain/entities/order_track_entity.dart';
import 'package:uuid/uuid.dart';

class CheckOutRemoteDataSource {
  final DataBaseService dataBaseService;
  final NetworkInfo networkInfo;
  CheckOutRemoteDataSource({
    required this.networkInfo,
    required this.dataBaseService,
  });

  Future<void> addOrder({required OrderInputEntity order}) async {
    if (await networkInfo.isConnected == true) {
      try {
        await dataBaseService.setData(
          path: ApiPath.addOrders(orderId: Uuid().v4(), userId: getUser().uid),
          data: OrderModel.fromEntity(order).toJson(),
        );
      } catch (e) {
        throw CustomException(message: e.toString());
      }
    } else {
      throw CustomException(message: 'No internet connection');
    }
  }
}
