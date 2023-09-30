import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:on_point_delivery/authenticator/app_navigator.dart';
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
                return CartPage();
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
                return FavoritesPage();
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
                return SessionNavigator();
              },
              routes: [
                GoRoute(
                  path: 'profileEditor/:title/:label/:value/:field',
                  builder: (context, state) {
                    final String title = state.pathParameters['title']!;
                    final String label = state.pathParameters['label']!;
                    final String value = state.pathParameters['value']!;
                    final String field = state.pathParameters['field']!;
                    return ProfileEditorPage(title: title, label: label, value: value,field: field,);
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
