import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_point_delivery/bloc/shipping/shipping_bloc.dart';
import 'package:on_point_delivery/views/address/billing.dart';

class ShippingPage extends StatelessWidget {
	 ShippingPage({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

	@override
	Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            children: [
	    _firstName(),
	    SizedBox(height: 8.h),
	    _lastName(),
	    SizedBox(height: 8.h),
	    _company(),
	    SizedBox(height: 8.h),
	    _address1(),
	    SizedBox(height: 8.h),
	    _address2(),
	    SizedBox(height: 8.h),
	    _city(),
	    SizedBox(height: 8.h),
	    _state(),
	    SizedBox(height: 8.h),
	    _postcode(),
	    SizedBox(height: 8.h),
	    _country(),
	    SizedBox(height: 8.h),
	    _email(),
	    SizedBox(height: 8.h),
	    _phone(),
	    SizedBox(height: 8.h),
	    _nif(),
	    SizedBox(height: 8.h),
            ],
          ),
        ),
      ),
    );
	}
  Widget _firstName() {
    return BlocBuilder<ShippingBloc, ShippingState>(
      builder: (context, state) {
        return InputTextForm(
          initialValue: state.customerBilling.firstName,
          labelText: 'Primeiro nome',
          icon: Icons.person_outlined,
          onChanged: (value)=>context.read<BillingBloc>().add(changeBillingFirstName(firstName: value)),
        );
      },
    );
  }
  Widget _lastName() {
    return BlocBuilder<BillingBloc, BillingState>(
      builder: (context, state) {
        return InputTextForm(
          initialValue: state.customerBilling.lastName,
          labelText: 'Ultimo nome',
          icon: Icons.person_outlined,
          onChanged: (value)=>context.read<BillingBloc>().add(changeBillingFirstName(firstName: value)),
        );
      },
    );
  }
  Widget _company() {
    return BlocBuilder<BillingBloc, BillingState>(
      builder: (context, state) {
        return InputTextForm(
          initialValue: state.customerBilling.company,
          labelText: 'Nome de Empresa',
          icon: Icons.store_outlined,
          onChanged: (value)=>context.read<BillingBloc>().add(changeBillingFirstName(firstName: value)),
        );
      },
    );
  }
  Widget _address1() {
    return BlocBuilder<BillingBloc, BillingState>(
      builder: (context, state) {
        return InputTextForm(
          initialValue: state.customerBilling.address_1,
          labelText: 'Morada',
          icon: Icons.location_on_outlined,
          onChanged: (value)=>context.read<BillingBloc>().add(changeBillingFirstName(firstName: value)),
        );
      },
    );
  }
  Widget _address2() {
    return BlocBuilder<BillingBloc, BillingState>(
      builder: (context, state) {
        return InputTextForm(
          initialValue: state.customerBilling.address_2,
          labelText: 'Morada',
          icon: Icons.location_on_outlined,
          onChanged: (value)=>context.read<BillingBloc>().add(changeBillingFirstName(firstName: value)),
        );
      },
    );
  }
  Widget _city() {
    return BlocBuilder<BillingBloc, BillingState>(
      builder: (context, state) {
        return InputTextForm(
          initialValue: state.customerBilling.city,
          labelText: 'Cidade',
          icon: Icons.location_city_outlined,
          onChanged: (value)=>context.read<BillingBloc>().add(changeBillingFirstName(firstName: value)),
        );
      },
    );
  }
  Widget _state() {
    return BlocBuilder<BillingBloc, BillingState>(
      builder: (context, state) {
        return InputTextForm(
          initialValue: state.customerBilling.state,
          labelText: 'Estado',
          icon: Icons.flag,
          onChanged: (value)=>context.read<BillingBloc>().add(changeBillingFirstName(firstName: value)),
        );
      },
    );
  }
  Widget _postcode() {
    return BlocBuilder<BillingBloc, BillingState>(
      builder: (context, state) {
        return InputTextForm(
          initialValue: state.customerBilling.postcode,
          labelText: 'Codigo Postal',
          icon: Icons.cloud_done_outlined,
          onChanged: (value)=>context.read<BillingBloc>().add(changeBillingFirstName(firstName: value)),
        );
      },
    );
  }
  Widget _country() {
    return BlocBuilder<BillingBloc, BillingState>(
      builder: (context, state) {
        return InputTextForm(
          initialValue: state.customerBilling.country,
          labelText: 'Pais',
          icon: Icons.flag,
          onChanged: (value)=>context.read<BillingBloc>().add(changeBillingFirstName(firstName: value)),
        );
      },
    );
  }
  Widget _email() {
    return BlocBuilder<BillingBloc, BillingState>(
      builder: (context, state) {
        return InputTextForm(
          initialValue: state.customerBilling.email,
          labelText: 'E-mail',
          icon: Icons.email_outlined,
          onChanged: (value)=>context.read<BillingBloc>().add(changeBillingFirstName(firstName: value)),
        );
      },
    );
  }
  Widget _phone() {
    return BlocBuilder<BillingBloc, BillingState>(
      builder: (context, state) {
        return InputTextForm(
          initialValue: state.customerBilling.phone,
          labelText: 'Telefone/Telemovel',
          icon: Icons.phone_outlined,
          onChanged: (value)=>context.read<BillingBloc>().add(changeBillingFirstName(firstName: value)),
        );
      },
    );
  }
  Widget _nif() {
    return BlocBuilder<BillingBloc, BillingState>(
      builder: (context, state) {
        return InputTextForm(
          initialValue: state.customerBilling.nif,
          labelText: 'NIF',
          icon: Icons.person_outlined,
          onChanged: (value)=>context.read<BillingBloc>().add(changeBillingFirstName(firstName: value)),
        );
      },
    );
  }
}
