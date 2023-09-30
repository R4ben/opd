import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:on_point_delivery/authenticator/app_navigator.dart';
import 'package:on_point_delivery/authenticator/session/session_bloc.dart';
import '../bloc/bloc.dart';
import '../model/models.dart';
import '../views/views.dart';

final GlobalKey<NavigatorState> _rootNavKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _storeNavKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _cartKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _favoriteKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _profileKey = GlobalKey<NavigatorState>();
final routes = GoRouter(
  navigatorKey: _rootNavKey,
  routerNeglect: true,
  initialLocation: '/',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (BuildContext context, GoRouterState state,
          StatefulNavigationShell navigationShell) {
        return MainScreen(
          navigationShell: navigationShell,
        );
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _storeNavKey,
          routes: [
            GoRoute(
              path: '/',
              builder: (context, GoRouterState state) => const StorePage(),
              routes: [
                GoRoute(
                  path: 'categoryPage/:categoryId',
                  builder: (context, GoRouterState state) {
                    CategoryModel category = (context.read<CategoryBloc>().state
                            as CategoryLoaded)
                        .categories
                        .firstWhere((category) =>
                            category.id == state.pathParameters['categoryId']!);
                    return CategoryPage(
                      category: category,
                    );
                  },
                ),
                GoRoute(
                  path: 'productPage/:productId',
                  pageBuilder: (context, GoRouterState state) {
                    Product product = (context.read<ProductBloc>().state
                            as ProductLoaded)
                        .products
                        .firstWhere((product) =>
                            product.id == state.pathParameters['productId']!);
                    return MaterialPage(
                      child: ProductDetails(
                        product: product,
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _cartKey,
          routes: [
            GoRoute(
              path: '/cartPage',
              builder: (context, state) {
                return const CartPage();
              },
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _favoriteKey,
          routes: [
            GoRoute(
              path: '/favorite',
              builder: (context, GoRouterState state) {
                return BlocBuilder<SessionBloc,SessionState>(
                  builder: (context,state) {
		  if(state is Authenticated){
                    return const FavoritesPage();
		  }else{return const FavoritesNoSession();}
                  }
                );
              },
            )
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _profileKey,
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, GoRouterState state) {
                return const SessionNavigator();
              },
              routes: [
                GoRoute(
                  path: 'nameEditor',
                  builder: (context, state) {
                    return NameEditor();
                  },
                ),
                GoRoute(
                  path: 'phoneEditor',
                  builder: (context, state) {
                    return PhoneEditor();
                  },
                ),
                GoRoute(
                  path: 'emailEditor',
                  builder: (context, state) {
                    return EmailEditor();
                  },
                ),
                GoRoute(
                  path: 'enderecoEditor',
                  builder: (context, state) {
                    return AddressPage();
                  },
                ),
              ],
            )
          ],
        ),
      ],
    ),
  ],
);
