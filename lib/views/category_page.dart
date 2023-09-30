import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../model/models.dart';
import '../bloc/bloc.dart';
import '../widgets/widgets.dart';

class CategoryPage extends StatelessWidget {
  final CategoryModel category;
  const CategoryPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 100.h,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      context.go('/');
                    },
                    child: const AppIcons(icon: Icons.clear)),
                GestureDetector(
                  onTap: () {
                    context.push('/cartPage');
                  },
                  child: Stack(children: [
                    const AppIcons(icon: Icons.shopping_cart_outlined),
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
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 11))),
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
                ),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20.h),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      topRight: Radius.circular(20.r)),
                ),
                width: double.maxFinite,
                padding: EdgeInsets.only(
                    top: 10.h, bottom: 10.h, right: 20.w, left: 20.w),
                child: Center(
                    child: Text(
                  category.name.toString(), //display product name
                  style: Theme.of(context).textTheme.bodyLarge,
                )),
              ),
            ),
            pinned: true,
            backgroundColor: Theme.of(context).colorScheme.primary,
            expandedHeight: 400.h,
            flexibleSpace: FlexibleSpaceBar(
                background: CachedNetworkImage(
              maxHeightDiskCache: 883.h.floor(),
              maxWidthDiskCache: 1080.w.floor(),
              imageUrl: category.imageUrl.toString(),
              width: double.infinity,
              fit: BoxFit.cover,
            )),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 12.w, right: 12.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h),
                      const ListProducts(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
