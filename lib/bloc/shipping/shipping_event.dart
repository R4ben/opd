part of 'shipping_bloc.dart';

abstract class ShippingEvent extends Equatable {}

class LoadShipping extends ShippingEvent {
  final CustomerShipping shipping;

  LoadShipping({required this.shipping});
  @override
  List<Object?> get props => [];
}

class UpdateShipping extends ShippingEvent {
  final String? firstName;
  final String? lastName;
  final String? company;
  final String? address_1;
  final String? address_2;
  final String? city;
  final String? state;
  final String? postcode;
  final String? country;

  UpdateShipping(
      {this.firstName,
      this.lastName,
      this.company,
      this.address_1,
      this.address_2,
      this.city,
      this.state,
      this.postcode,
      this.country});

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        company,
        address_1,
        address_2,
        city,
        state,
        postcode,
        country,
      ];
}
