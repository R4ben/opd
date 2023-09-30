part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class CartStarted extends CartEvent {
  @override
  List<Object?> get props => [];
}

class AddProductToCart extends CartEvent {
  final Product product;
  const AddProductToCart(this.product);
  @override
  // TODO: implement props
  List<Object?> get props => [product];
}

class RemoveProductFromCart extends CartEvent {
  final Product product;
  const RemoveProductFromCart(this.product);
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
