part of 'billing_bloc.dart';

class BillingState extends Equatable {
  final CustomerBilling customerBilling;
  String? firstNameValidator() {
    if (_hasFiveChars(customerBilling.firstName)) {
      return "Este campo deve ter pelo menos 5 ${customerBilling.firstName}";
    }
    return null;
  }

  String? companyValidator() {
    if (_hasFiveChars(customerBilling.company)) {
      return "Este campo deve ter pelo menos 5 caracteres";
    }
    return null;
  }

  String? address1Validator() {
    if (_hasFiveChars(customerBilling.address_1)) {
      return "Este campo deve ter pelo menos 5 caracteres";
    }
    return null;
  }

  String? address2Validator() {
    if (_hasFiveChars(customerBilling.address_2)) {
      return "Este campo deve ter pelo menos 5 caracteres";
    }
    return null;
  }

  String? cityValidator() {
    if (_hasFiveChars(customerBilling.city)) {
      return "Este campo deve ter pelo menos 5 caracteres";
    }
    return null;
  }

  String? stateValidator() {
    if (_hasFiveChars(customerBilling.state)) {
      return "Este campo deve ter pelo menos 5 caracteres";
    }
    return null;
  }

  String? postCodeValidator() {
    if (_hasFiveChars(customerBilling.postcode)) {
      return "Este campo deve ter pelo menos 5 caracteres";
    }
    return null;
  }

  String? countryValidator() {
    if (_hasFiveChars(customerBilling.country)) {
      return "Este campo deve ter pelo menos 5 caracteres";
    }
    return null;
  }

  String? emailValidator() {
    if (_hasFiveChars(customerBilling.email)) {
      return "Este campo deve ter pelo menos 5 caracteres";
    }
    return null;
  }

  String? phoneValidator() {
    if (_hasFiveChars(customerBilling.phone)) {
      return "Este campo deve ter pelo menos 5 caracteres";
    }
    return null;
  }

  String? nifValidator() {
    if (_hasFiveChars(customerBilling.nif)) {
      return "Este campo deve ter pelo menos 5 caracteres";
    }
    return null;
  }

  static bool _hasFiveChars(String value) => value.length < 5;

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
  }) {
    return BillingState(
        customerBilling: CustomerBilling(
      firstName: firstName ?? customerBilling.firstName,
      lastName: lastName ?? customerBilling.lastName,
      company: company ?? customerBilling.company,
      address_1: address_1 ?? customerBilling.address_1,
      address_2: address_2 ?? customerBilling.address_2,
      city: city ?? customerBilling.city,
      state: state ?? customerBilling.state,
      postcode: postcode ?? customerBilling.postcode,
      country: country ?? customerBilling.country,
      email: email ?? customerBilling.email,
      phone: phone ?? customerBilling.phone,
      nif: nif ?? customerBilling.nif,
    ));
  }

  @override
  List<Object> get props => [
        customerBilling,
      ];
}
