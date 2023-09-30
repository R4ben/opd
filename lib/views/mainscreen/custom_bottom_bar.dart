import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  int currentIndex = 0;

  @override
  void initState() {
    setState(() {
      currentIndex = widget.navigationShell.currentIndex;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(0.05.sw),
        height: 0.155.sw,
        decoration: BoxDecoration(
          color: Colors.white70,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 30,
                offset: Offset(0, 10)),
          ],
          borderRadius: BorderRadius.circular(50),
        ),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
          itemCount: items.length,
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              setState(() {
                currentIndex = index;
              });
              onTap(context, index);
              HapticFeedback.lightImpact();
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Stack(
              children: [
                AnimatedContainer(
                  duration: Duration(seconds: 1),
                  curve: Curves.fastLinearToSlowEaseIn,
                  width: index == currentIndex ? 0.32.sw : 0.18.sw,
                  alignment: Alignment.center,
                  child: AnimatedContainer(
                    duration: Duration(seconds: 1),
                    curve: Curves.fastLinearToSlowEaseIn,
                    height: index == currentIndex ? 0.12.sw : 0,
                    width: index == currentIndex ? 0.32.sw : 0,
                    decoration: BoxDecoration(
                      color: index == currentIndex
                          ? Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.8)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: Duration(seconds: 1),
                  curve: Curves.fastLinearToSlowEaseIn,
                  width: index == currentIndex ? 0.31.sw : 0.18.sw,
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          AnimatedContainer(
                            duration: Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            width: index == currentIndex ? 0.13.sw : 0,
                          ),
                          AnimatedOpacity(
                            duration: Duration(seconds: 1),
                            opacity: index == currentIndex ? 1 : 0,
                            curve: Curves.fastLinearToSlowEaseIn,
                            child: Text(
                              index == currentIndex
                                  ? '${items[index].label}'
                                  : '',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          AnimatedContainer(
                            duration: Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            width: index == currentIndex ? 0.03.sw : 20.w,
                          ),
                          Icon(
                            items[index].icon,
                            size: 0.076.sw,
                            color: index == currentIndex
                                ? Colors.white
                                : Colors.black26,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  List<CustomBottomBarItem> items = [
    CustomBottomBarItem(
        icon: Icons.storefront_outlined, routeName: '/', label: "Loja"),
    CustomBottomBarItem(
        icon: Icons.shopping_cart_outlined,
        routeName: '/cartPage',
        label: "Carrinho"),
    CustomBottomBarItem(
        icon: Icons.favorite_outlined,
        routeName: '/favorite',
        label: "Favoritos"),
    CustomBottomBarItem(
        icon: Icons.person_outlined, routeName: '/profile', label: "Perfil"),
  ];

  void onTap(BuildContext context, int index) {
    widget.navigationShell.goBranch(index,
        initialLocation: index == widget.navigationShell.currentIndex);
  }
}

class CustomBottomBarItem {
  CustomBottomBarItem(
      {required this.label, required this.routeName, required this.icon});
  final String routeName;
  final String label;
  final IconData icon;
}
