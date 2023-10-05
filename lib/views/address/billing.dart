import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bloc/billing/billing_bloc.dart';

class BillingPage extends StatelessWidget {
  BillingPage({super.key});
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
              SizedBox(height: 16.h),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                    } else {
                      context.read<BillingBloc>().add(UpdateBilling());
                    }
                  },
                  child: Text('Guardar Morada')),
              SizedBox(height: 8.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _firstName() {
    return BlocBuilder<BillingBloc, BillingState>(
      builder: (context, state) {
        return TextFormField(
          key: Key('firstName'),
          initialValue: state.customerBilling.firstName,
          decoration: const InputDecoration(
            labelText: 'Nome',
            icon: Icon(Icons.person_outlined),
          ),
          onChanged: (value) => context
              .read<BillingBloc>()
              .add(ChangeBillingFirstName(firstName: value)),
          validator: (value) => state.firstNameValidator(),
        );
      },
    );
  }

  Widget _lastName() {
    return BlocBuilder<BillingBloc, BillingState>(
      builder: (context, state) {
        TextEditingController lastNameController = TextEditingController();
        return InputTextForm(
          initialValue: state.customerBilling.lastName,
          key: const Key('lastName'),
          labelText: 'Apelido',
          icon: Icons.person_outlined,
          onChanged: (value) => context
              .read<BillingBloc>()
              .add(ChangeBillingLastName(lastName: value)),
          validator: (value) => state.firstNameValidator(),
          textController: lastNameController,
        );
      },
    );
  }

  Widget _company() {
    return BlocBuilder<BillingBloc, BillingState>(
      builder: (context, state) {
        TextEditingController companyController = TextEditingController();
        return InputTextForm(
          key: Key('company'),
          initialValue: state.customerBilling.company,
          labelText: 'Nome de Empresa',
          icon: Icons.store_outlined,
          onChanged: (value) => context
              .read<BillingBloc>()
              .add(ChangeBillingCompanyName(companyName: value)),
          validator: (value) => state.companyValidator(),
          textController: companyController,
        );
      },
    );
  }

  Widget _address1() {
    return BlocBuilder<BillingBloc, BillingState>(
      builder: (context, state) {
        TextEditingController address1Controller = TextEditingController();
        return InputTextForm(
          key: Key('address1'),
          initialValue: state.customerBilling.address_1,
          labelText: 'Morada',
          icon: Icons.location_on_outlined,
          onChanged: (value) => context
              .read<BillingBloc>()
              .add(ChangeBillingAddress1Name(address1: value)),
          validator: (value) => state.address1Validator(),
          textController: address1Controller,
        );
      },
    );
  }

  Widget _address2() {
    return BlocBuilder<BillingBloc, BillingState>(
      builder: (context, state) {
        TextEditingController address2Controller = TextEditingController();
        return InputTextForm(
          key: Key('address2'),
          initialValue: state.customerBilling.address_2,
          labelText: 'Morada',
          icon: Icons.location_on_outlined,
          onChanged: (value) => context
              .read<BillingBloc>()
              .add(ChangeBillingAddress2Name(address2: value)),
          validator: (value) => state.address2Validator(),
          textController: address2Controller,
        );
      },
    );
  }

  Widget _city() {
    return BlocBuilder<BillingBloc, BillingState>(
      builder: (context, state) {
        TextEditingController cityController = TextEditingController();
        return InputTextForm(
          key: Key('city'),
          initialValue: state.customerBilling.city,
          labelText: 'Localidade',
          icon: Icons.location_city_outlined,
          onChanged: (value) =>
              context.read<BillingBloc>().add(ChangeBillingCity(city: value)),
          validator: (value) => state.cityValidator(),
          textController: cityController,
        );
      },
    );
  }

  Widget _state() {
    return BlocBuilder<BillingBloc, BillingState>(
      builder: (context, state) {
        TextEditingController stateController = TextEditingController();
        return InputTextForm(
          key: Key('state'),
          initialValue: state.customerBilling.state,
          labelText: 'Estado',
          icon: Icons.flag,
          onChanged: (value) =>
              context.read<BillingBloc>().add(ChangeBillingState(state: value)),
          validator: (value) => state.stateValidator(),
          textController: stateController,
        );
      },
    );
  }

  Widget _postcode() {
    return BlocBuilder<BillingBloc, BillingState>(
      builder: (context, state) {
        TextEditingController postCodeController = TextEditingController();
        return InputTextForm(
          key: Key('postcode'),
          initialValue: state.customerBilling.postcode,
          labelText: 'Código postal',
          icon: Icons.local_post_office_outlined,
          onChanged: (value) => context
              .read<BillingBloc>()
              .add(ChangeBillingPostCode(postCode: value)),
          validator: (value) => state.postCodeValidator(),
          textController: postCodeController,
        );
      },
    );
  }

  Widget _country() {
    return BlocBuilder<BillingBloc, BillingState>(
      builder: (context, state) {
        TextEditingController countryController = TextEditingController();
        return InputTextForm(
          key: Key('country'),
          initialValue: state.customerBilling.country,
          labelText: 'Pais',
          icon: Icons.flag,
          onChanged: (value) => context
              .read<BillingBloc>()
              .add(ChangeBillingCountry(country: value)),
          validator: (value) => state.countryValidator(),
          textController: countryController,
        );
      },
    );
  }

  Widget _email() {
    return BlocBuilder<BillingBloc, BillingState>(
      builder: (context, state) {
        TextEditingController emailController = TextEditingController();
        return InputTextForm(
          key: Key('email'),
          initialValue: state.customerBilling.email,
          labelText: 'Endereço de email',
          icon: Icons.email_outlined,
          onChanged: (value) =>
              context.read<BillingBloc>().add(ChangeBillingEmail(email: value)),
          validator: (value) => state.emailValidator(),
          textController: emailController,
        );
      },
    );
  }

  Widget _phone() {
    return BlocBuilder<BillingBloc, BillingState>(
      builder: (context, state) {
        TextEditingController phoneController = TextEditingController();
        return InputTextForm(
          key: Key('phone'),
          initialValue: state.customerBilling.phone,
          labelText: 'Telefone/Telemovel',
          icon: Icons.phone_outlined,
          onChanged: (value) =>
              context.read<BillingBloc>().add(ChangeBillingPhone(phone: value)),
          validator: (value) => state.phoneValidator(),
          textController: phoneController,
        );
      },
    );
  }

  Widget _nif() {
    return BlocBuilder<BillingBloc, BillingState>(
      builder: (context, state) {
        TextEditingController nifController = TextEditingController();
        return InputTextForm(
          key: Key('nif'),
          initialValue: state.customerBilling.nif,
          labelText: 'NIF',
          icon: Icons.person_outlined,
          onChanged: (value) =>
              context.read<BillingBloc>().add(ChangeBillingNif(nif: value)),
          validator: (value) => state.nifValidator(),
          textController: nifController,
        );
      },
    );
  }
}

class InputTextForm extends StatelessWidget {
  const InputTextForm({
    required this.initialValue,
    required this.labelText,
    required this.icon,
    required this.onChanged,
    required this.validator,
    super.key,
    required this.textController,
  });
  final TextEditingController textController;
  final String initialValue;
  final String labelText;
  final IconData icon;
  final String? Function(String?) validator;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onChanged: onChanged,
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: labelText,
        icon: Icon(icon),
      ),
    );
  }
}
