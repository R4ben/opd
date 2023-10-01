import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_point_delivery/model/billing.dart';
import 'package:on_point_delivery/repo/repo.dart';

part 'billing_event.dart';
part 'billing_state.dart';

class BillingBloc extends Bloc<BillingEvent, BillingState> {
  final BillingRepo _billingRepo;
  BillingBloc({required BillingRepo billingRepo})
      : _billingRepo = billingRepo,
        super(BillingState(customerBilling: CustomerBilling.isEmpty)) {
    on<LoadBilling>((event, emit) async {
      try {
        CustomerBilling customerBilling = await _billingRepo.getBilling();
      } catch (e) {
        print(e);
      }
    });

    on<ChangeBillingFirstName>((event, emit) {
      emit(state.copyWith(firstName: event.firstName));
    });
    on<ChangeBillingLastName>((event, emit) {
      emit(state.copyWith(firstName: event.lastName));
    });
    on<ChangeBillingCompanyName>((event, emit) {
      emit(state.copyWith(firstName: event.companyName));
    });
    on<ChangeBillingAddress1Name>((event, emit) {
      emit(state.copyWith(firstName: event.address1));
    });
    on<ChangeBillingAddress1Name>((event, emit) {
      emit(state.copyWith(firstName: event.address1));
    });
    on<ChangeBillingAddress2Name>((event, emit) {
      emit(state.copyWith(firstName: event.address2));
    });
    on<ChangeBillingCity>((event, emit) {
      emit(state.copyWith(firstName: event.city));
    });
    on<ChangeBillingState>((event, emit) {
      emit(state.copyWith(firstName: event.state));
    });
    on<ChangeBillingPostCode>((event, emit) {
      emit(state.copyWith(firstName: event.postCode));
    });
    on<ChangeBillingCountry>((event, emit) {
      emit(state.copyWith(firstName: event.country));
    });
    on<ChangeBillingEmail>((event, emit) {
      emit(state.copyWith(firstName: event.email));
    });
    on<ChangeBillingPhone>((event, emit) {
      emit(state.copyWith(firstName: event.phone));
    });
    on<ChangeBillingNif>((event, emit) {
      emit(state.copyWith(firstName: event.nif));
    });
  }
}
