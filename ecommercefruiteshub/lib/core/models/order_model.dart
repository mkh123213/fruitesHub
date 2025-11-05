import 'package:ecommercefruiteshub/core/models/order_product_model.dart';
import 'package:ecommercefruiteshub/core/models/shipping_address_model.dart';
import 'package:ecommercefruiteshub/features/profile/domain/entities/order_track_entity.dart';
import 'package:uuid/uuid.dart';

import '../entities/order_entity.dart';

class OrderModel {
  final double totalPrice;
  final int currentTrackStep;
  final String uId;
  final ShippingAddressModel shippingAddressModel;
  final List<OrderProductModel> orderProducts;
  final String paymentMethod;
  final String orderId;
  final String? date;
  OrderModel({
    this.date,
    required this.currentTrackStep,
    required this.totalPrice,
    required this.uId,
    required this.orderId,
    required this.shippingAddressModel,
    required this.orderProducts,
    required this.paymentMethod,
  });

  factory OrderModel.fromEntity(OrderInputEntity orderEntity) {
    return OrderModel(
      currentTrackStep: orderEntity.currentTrackStep ?? 0,
      orderId: orderEntity.uID,
      totalPrice: orderEntity.cartEntity.calculateTotalPrice().toDouble(),
      uId: orderEntity.uID,
      shippingAddressModel: ShippingAddressModel.fromEntity(
        orderEntity.shippingAddressEntity,
      ),
      orderProducts: orderEntity.cartEntity.items
          .map((e) => OrderProductModel.fromEntity(cartItemEntity: e))
          .toList(),
      paymentMethod: orderEntity.payWithCash! ? 'Cash' : 'Paypal',
    );
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    currentTrackStep: json['currentStep'],
    date: json['date'],
    orderId: json['orderId'],
    totalPrice: json['totalPrice'],
    uId: json['uId'],
    shippingAddressModel: ShippingAddressModel.fromJson(
      json['shippingAddressModel'],
    ),
    orderProducts: (json['orderProducts'] as List<dynamic>)
        .map((e) => OrderProductModel.fromJson(e as Map<String, dynamic>))
        .toList(),

    paymentMethod: json['paymentMethod'],
  );
  OrderTrack toTrack() {
    return OrderTrack(
      uid: uId,
      date: date!,
      currentStep: currentTrackStep,
      orderCounts: orderProducts.length,
      totalPrice: totalPrice,
    );
  }

  toJson() => {
    'currentStep': currentTrackStep,
    'orderId': orderId,
    'totalPrice': totalPrice,
    'uId': uId,
    'status': 'pending',
    'date': DateTime.now().toString(),
    'shippingAddressModel': shippingAddressModel.toJson(),
    'orderProducts': orderProducts.map((e) => e.toJson()).toList(),
    'paymentMethod': paymentMethod,
  };
}

// payment method
