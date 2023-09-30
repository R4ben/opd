import 'package:equatable/equatable.dart';

class AdressModel extends Equatable {
  final String zipCode;
  final String address_1;
  final String address_2;
  final String city;
  final String country;
  final String island;
  final String email;
  final String phone;

  AdressModel(this.zipCode, this.address_1, this.address_2, this.city,
      this.country, this.island, this.email, this.phone);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
