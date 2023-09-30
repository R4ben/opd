import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/models.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartEmpty()) {
    on<AddProductToCart>(_onAddProductToCart);
    on<RemoveProductFromCart>(_onRemoveProductFromCart);
    on<CartStarted>((event, emit) {
      emit(CartEmpty());
      try {
        emit(CartHasProduct());
      } catch (_) {}
    });
  }
  void _onAddProductToCart(
      AddProductToCart event, Emitter<CartState> emit) async {
    if (state is CartHasProduct) {
      final state = this.state as CartHasProduct;
      try {
        emit(
          CartHasProduct(
              cart: CartModel(
                  products: List.from(state.cart.products)
                    ..add(event.product))),
        );
      } catch (_) {}
    }
  }

  void _onRemoveProductFromCart(
      RemoveProductFromCart event, Emitter<CartState> emit) async {
    if (state is CartHasProduct) {
      final state = this.state as CartHasProduct;
      try {
        emit(
          CartHasProduct(
              cart: CartModel(
                  products: List.from(state.cart.products)
                    ..remove(event.product))),
        );
      } catch (_) {}
    }
  }
}
