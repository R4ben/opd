part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartEmpty extends CartState {
  const CartEmpty();

  @override
  List<Object> get props => [];
}

class CartHasProduct extends CartState {
  final CartModel cart;

  const CartHasProduct({this.cart = const CartModel()});

  @override
  List<Object> get props => [cart];
}
