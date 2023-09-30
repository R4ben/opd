import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../authenticator/app_navigator.dart';
import '../bloc/bloc.dart';
import 'views.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PersistentTabController _controller;
  @override
  void initState() {
    _controller = PersistentTabController(initialIndex: 0);
    super.initState();
  }

  List<Widget> _buildScreens() {
    return [
      CartPage(),
      const SessionNavigator(),
      // const SaPAdmin(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.storefront_outlined),
        title: ("Home"),
        activeColorPrimary: Theme.of(context).colorScheme.background,
        inactiveColorPrimary: CupertinoColors.systemGrey2,
      ),
      PersistentBottomNavBarItem(
        icon: Stack(children: [
          const Icon(Icons.shopping_cart_outlined),
          BlocBuilder<CartBloc, CartState>(builder: (context, state) {
            if (state is CartHasProduct) {
              if (state.cart
                  .productQuantity(state.cart.products)
                  .keys
                  .isNotEmpty) {
                return Positioned(
                  right: 0.r,
                  top: 0.r,
                  child: Container(
                    width: 20.r,
                    height: 20.r,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: Colors.red),
                    child: Center(
                        child: Text(
                            '${state.cart.productQuantity(state.cart.products).keys.length}',
                            style:
                                TextStyle(color: Colors.white, fontSize: 11))),
                  ),
                );
              } else {
                return Container();
              }
            } else {
              return Container();
            }
          }),
        ]),
        title: ("Carrinho"),
        activeColorPrimary: Theme.of(context).colorScheme.background,
        inactiveColorPrimary: CupertinoColors.systemGrey2,
      ),
      PersistentBottomNavBarItem(
        textStyle: Theme.of(context).textTheme.labelMedium,
        icon: const Icon(Icons.person_outlined),
        title: ("Perfil"),
        activeColorPrimary: Theme.of(context).colorScheme.background,
        inactiveColorPrimary: CupertinoColors.systemGrey2,
      ),
      // PersistentBottomNavBarItem(
      //   icon: const Icon(Icons.settings_outlined),
      //   title: ("Settings"),
      //   activeColorPrimary: CupertinoColors.activeBlue,
      //   inactiveColorPrimary: CupertinoColors.systemGrey,
      // ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor:
            Theme.of(context).colorScheme.primary, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset:
            true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows:
            true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 300),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 300),
        ),
        navBarStyle:
            NavBarStyle.style1, // Choose the nav bar style with this property.
      ),
    );
  }
}
