import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_point_delivery/bloc/shipping/shipping_bloc.dart';

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
            ],
          ),
        ),
      ),
    );
  }

  Widget _firstName() {
    return BlocBuilder<ShippingBloc, ShippingState>(
      builder: (context, state) {
        if (state is ShippingLoaded) {
          return TextFormField(
            key: const Key('firstName'),
            initialValue: state.shipping.firstName,
            decoration: const InputDecoration(
              labelText: 'Nome',
              icon: Icon(Icons.person_outlined),
            ),
            onChanged: (value) => context
                .read<ShippingBloc>()
                .add(UpdateShipping(firstName: value)),
            validator: (value) {},
          );
        } else {
          return Container(
            child: Center(child: const Text('Algo deu Errado')),
          );
        }
      },
    );
  }
}
