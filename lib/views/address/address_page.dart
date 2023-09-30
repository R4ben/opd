import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_point_delivery/authenticator/session/session_bloc.dart';
import 'package:on_point_delivery/bloc/billing/billing_bloc.dart';
import 'package:on_point_delivery/repo/repo.dart';
import 'package:on_point_delivery/views/profile/profile_editor.dart';

import '../../bloc/shipping/shipping_bloc.dart';
import 'billing.dart';
import 'shipping.dart';


class AddressPage extends StatelessWidget {
  AddressPage({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Editar Enderecos'),
          bottom: TabBar(tabs: [
            Tab(text: 'Faturacao'),
	    Tab(text: 'Entrega')
          ]),
        ),
        body: MultiRepositoryProvider(
		providers: [
		RepositoryProvider(create: (context)=>BillingRepo(userId: context.read<SessionBloc>().user.id!))
		],
          child: MultiBlocProvider(
		providers: [
BlocProvider(create: (context)=>BillingBloc(billingRepo: context.read<BillingRepo>())..add(LoadBilling())),
BlocProvider(create: (context)=>ShippingBloc()),
		],
            child: TabBarView(
		children: [
		BillingPage(),
		ShippingPage(),
		],
            ),
          ),
        ),
      ),
    );
  }
}
