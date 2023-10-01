part of 'billing_bloc.dart';

class BillingState extends Equatable {
  final CustomerBilling customerBilling;
  String? firstNameValidator(String value){
	  if(_hasFiveChars(value)){
	  return "Este campo de ter pelo menos 5 caracteres";
	  }
	return null;
  }

  String? companyValidator(){}
  String? address1Validator(){}
  String? address2Validator(){}
  String? cityValidator(){}
  String? stateValidator(){}
  String? postCodeValidator(){}
  String? countryValidator(){}
  String? emailValidator(){}
  String? phoneValidator(){}

  static bool _hasFiveChars(String value)=>value.length<5;

  const BillingState({required this.customerBilling});

  BillingState copyWith({
   String? firstName,
   String? lastName,
   String? company,
   String? address_1,
   String? address_2,
   String? city,
   String? state,
   String? postcode,
   String? country,
   String? email,
   String? phone,
   String? nif,
   }){
    return BillingState(
        customerBilling: customerBilling.copyWith(
      firstName: firstName,
      lastName: lastName,
      company: company,
      address_1: address_1,
      address_2: address_2,
      city: city,
      state: state,
      postcode: postcode,
      country: country,
      email: email,
      phone: phone,
      nif: nif,
    ));
  }

  @override
  List<Object> get props => [
        customerBilling,
      ];
}
