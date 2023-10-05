import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_point_delivery/authenticator/session/session_bloc.dart';
import 'package:on_point_delivery/bloc/billing/billing_bloc.dart';
import 'package:on_point_delivery/repo/repo.dart';
import 'package:on_point_delivery/repo/shipping/shipping.dart';

import '../../bloc/shipping/shipping_bloc.dart';
import 'billing.dart';
import 'shipping.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Editar Enderecos'),
          bottom: const TabBar(tabs: [
            Tab(text: 'Morada de facturação'),
            Tab(text: 'Morada de envio')
          ]),
        ),
        body: MultiRepositoryProvider(
          providers: [
            RepositoryProvider(
                create: (context) =>
                    BillingRepo(userId: context.read<SessionBloc>().user.id!)),
            RepositoryProvider(
                create: (context) => ShippingRepository(
                    userId: context.read<SessionBloc>().user.id!))
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) =>
                      BillingBloc(billingRepo: context.read<BillingRepo>())
                        ..add(LoadBilling())),
              BlocProvider(
                  create: (context) => ShippingBloc(
                      shippingRepository: context.read<ShippingRepository>())),
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
