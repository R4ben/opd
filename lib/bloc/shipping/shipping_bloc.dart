import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_point_delivery/model/shipping.dart';
import 'package:on_point_delivery/repo/shipping/shipping.dart';
part 'shipping_event.dart';
part 'shipping_state.dart';

class ShippingBloc extends Bloc<ShippingEvent, ShippingState> {
  final ShippingRepository _shippingRepository;
  CustomerShipping _shipping = const CustomerShipping.empty();
  late StreamSubscription? _shippingSubscription;
  ShippingBloc({required ShippingRepository shippingRepository})
      : _shippingRepository = shippingRepository,
        super(ShippingInitial()) {
    _shippingSubscription =
        _shippingRepository.getShipping().listen((shipping) {
      add(LoadShipping(shipping: shipping));
    });
    on<UpdateShipping>((event, emit) {
      _updateShipping(
        firstName: event.firstName,
        lastName: event.lastName,
        company: event.company,
        address_1: event.address_1,
        address_2: event.address_2,
        city: event.city,
        state: event.city,
        postcode: event.postcode,
        country: event.country,
      );
      emit(ShippingLoaded(shipping: _shipping));
    });
  }
  void _updateShipping({
    String? firstName,
    String? lastName,
    String? company,
    String? address_1,
    String? address_2,
    String? city,
    String? state,
    String? postcode,
    String? country,
  }) {
    _shipping = _shipping.copyWith(
      firstName: firstName,
      lastName: lastName,
      company: company,
      address_1: address_1,
      address_2: address_2,
      city: city,
      state: state,
      postcode: postcode,
      country: country,
    );
  }

  @override
  Future<void> close() async {
    _shippingSubscription?.cancel();
    super.close();
  }
}
