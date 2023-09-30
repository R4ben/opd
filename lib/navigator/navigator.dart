import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc.dart';
import '../views/views.dart';

class AppNavigator extends StatelessWidget {
  const AppNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Navigator(
          pages: [
            if (state is ShowSplashScreen)
              const MaterialPage(child: SplashScreen()),
            if (state is ShowHomePage) const MaterialPage(child: HomePage()),
            if (state is ShowCartPage) const MaterialPage(child: CartPage()),
            if (state is ShowAddressPage) MaterialPage(child: AddressPage()),
            if (state is ShowProductDetailsPage)
              MaterialPage(
                  child: ProductDetails(
                product: state.product,
              )),
            if (state is ShowCategoryPage)
              MaterialPage(
                  child: CategoryPage(
                category: state.category,
              )),
          ],
          onPopPage: (route, result) {
            return route.didPop(result);
          },
        );
      },
    );
  }
}
