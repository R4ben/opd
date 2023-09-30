import 'package:equatable/equatable.dart';

import 'models.dart';

class CartModel extends Equatable {
  final List<Product> products;
  const CartModel({this.products = const <Product>[]});

  int total(subTotal, deliveryFee) {
    return subTotal + deliveryFee;
  }

  Map productQuantity(products) {
    var quantity = {};

    products.forEach((product) {
      if (!quantity.containsKey(product)) {
        quantity[product] = 1;
      } else {
        quantity[product] += 1;
      }
    });
    return quantity;
  }

  String get totalString => total(subTotal, deliveryFee).toString();
  int get subTotal =>
      products.fold(0, (total, current) => total + current.price);

  int deliveryFee(subTotal) {
    if (subTotal >= 5000) {
      return 0;
    } else {
      return 2000;
    }
  }

  String freeDelivery(subTotal) {
    if (subTotal >= 5000) {
      return "Entrega gratis";
    } else {
      int missing = subTotal - 5000;
      return 'Adicionar \$${missing.toString()}';
    }
  }

  String get subTotalString => subTotal.toString();
  String get deliveryFeeString => deliveryFee(subTotal).toString();
  String get freeDeliveryString => freeDelivery(subTotal);

  @override
  // TODO: implement props
  List<Object?> get props => [products];
}
