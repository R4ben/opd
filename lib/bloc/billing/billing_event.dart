part of 'billing_bloc.dart';

abstract class BillingEvent extends Equatable {}

class LoadBilling extends BillingEvent{
  @override
  List<Object> get props =>[];
}

class ChangeBillingFirstName extends BillingEvent{
final String firstName;

  ChangeBillingFirstName({required this.firstName});
  @override
  List<Object> get props => [firstName];
}

class ChangeBillingLastName extends BillingEvent{
final String lastName;

  ChangeBillingLastName({required this.lastName});
  @override
  List<Object> get props => [lastName];
}

class ChangeBillingCompanyName extends BillingEvent{
final String companyName;

  ChangeBillingCompanyName({required this.companyName});
  @override
  List<Object> get props => [companyName];
}

class ChangeBillingAddress1Name extends BillingEvent{
final String address1;

  ChangeBillingAddress1Name({required this.address1});
  @override
  List<Object> get props => [address1];
}
class ChangeBillingAddress2Name extends BillingEvent{
final String address2;

  ChangeBillingAddress2Name({required this.address2});
  @override
  List<Object> get props => [address2];
}
class ChangeBillingCity extends BillingEvent{
final String city;

  ChangeBillingCity({required this.city});
  @override
  List<Object> get props => [city];
}
class ChangeBillingState extends BillingEvent{
final String state;

  ChangeBillingState({required this.state});
  @override
  List<Object> get props => [state];
}
class ChangeBillingPostCode extends BillingEvent{
final String postCode;

  ChangeBillingPostCode({required this.postCode});
  @override
  List<Object> get props => [postCode];
}
class ChangeBillingCountry extends BillingEvent{
final String country;

  ChangeBillingCountry({required this.country});
  @override
  List<Object> get props => [country];
}
class ChangeBillingEmail extends BillingEvent{
final String email;

  ChangeBillingEmail({required this.email});
  @override
  List<Object> get props => [email];
}
class ChangeBillingPhone extends BillingEvent{
final String phone;

  ChangeBillingPhone({required this.phone});
  @override
  List<Object> get props => [phone];
}
class ChangeBillingNif extends BillingEvent{
final String nif;

  ChangeBillingNif({required this.nif});
  @override
  List<Object> get props => [nif];
}
