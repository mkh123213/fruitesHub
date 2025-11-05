// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommercefruiteshub/core/entities/product_entity.dart';
import 'package:equatable/equatable.dart';

class CartItemEntity extends Equatable {
  final ProductEntity productEntity;
  final int quantity;
  CartItemEntity({required this.productEntity, required this.quantity});

  num itemPrice() => productEntity.price * quantity;

  CartItemEntity copyWith({ProductEntity? product, int? quantity}) {
    return CartItemEntity(
      productEntity: product ?? this.productEntity,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [productEntity];
}
