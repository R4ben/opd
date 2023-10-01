
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CustomerShipping extends Equatable {
  final String firstName;
  final String lastName;
  final String company;
  final String address_1;
  final String address_2;
  final String city;
  final String state;
  final String postcode;
  final String country;

  const CustomerShipping({
    required this.firstName,
    required this.lastName,
    required this.company,
    required this.address_1,
    required this.address_2,
    required this.city,
    required this.state,
    required this.postcode,
    required this.country,
  });
  factory CustomerShipping.fromDocument(DocumentSnapshot snap) {
    return CustomerShipping(
      firstName: snap['firstName'],
      lastName: snap['lastName'],
      company: snap['company'],
      address_1: snap['address_1'],
      address_2: snap['address_2'],
      city: snap['city'],
      state: snap['state'],
      postcode: snap['postcode'],
      country: snap['country'],
    );
  }
  Map<String, dynamic> toDocument() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'company': company,
      'address_1': address_1,
      'address_2': address_2,
      'city': city,
      'state': state,
      'postcode': postcode,
      'country': country,
    };
  }

  @override
  List<Object?> get props => [];
}
