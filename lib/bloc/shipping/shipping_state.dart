part of 'shipping_bloc.dart';

abstract class ShippingState extends Equatable {}

class ShippingInitial extends ShippingState {
  @override
  List<Object?> get props => [];
}

class ShippingLoaded extends ShippingState {
  final CustomerShipping shipping;

  ShippingLoaded({required this.shipping});
  @override
  List<Object?> get props => [shipping];
}
