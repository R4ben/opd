import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/cart/cart_bloc.dart';
import '../../model/models.dart';
import '../../widgets/widgets.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Stack(
        children: [
          Positioned(
            top: 20.h * 3,
            left: 20.w,
            right: 20.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Back arrow
                GestureDetector(
                  onTap: () => context.pop(),
                  child: AppIcons(
                    icon: Icons.arrow_back_ios,
                    iconColor: Colors.white,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    iconSize: 24.r,
                  ),
                ),
                GestureDetector(
                  onTap: () => context.go('/'),
                  child: AppIcons(
                    icon: Icons.storefront_outlined,
                    iconColor: Colors.white,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    iconSize: 24.r,
                  ),
                ),
                AppIcons(
                  icon: Icons.shopping_cart_outlined,
                  iconColor: Colors.white,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  iconSize: 24.r,
                )
              ],
            ),
          ),
          Positioned(
            top: 22.h * 5,
            left: 20.w,
            right: 20.w,
            bottom: 0,
            child: Container(
              margin: EdgeInsets.only(top: 15.h),
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    if (state is CartHasProduct) {
                      return ListView.builder(
                          itemCount: state.cart
                              .productQuantity(state.cart.products)
                              .keys
                              .length,
                          itemBuilder: (context, index) {
                            return BuildCartItems(
                              product: state.cart
                                  .productQuantity(state.cart.products)
                                  .keys
                                  .elementAt(index),
                              key: ValueKey(state.cart.products[index].id),
                              quantity: state.cart
                                  .productQuantity(state.cart.products)
                                  .values
                                  .elementAt(index),
                            );
                          });
                    } else {
                      return Center(
                        child: Text('Algo deu errado!'),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 130.h,
        padding:
            EdgeInsets.only(top: 30.h, bottom: 30.h, left: 20.w, right: 20.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r * 2),
              topRight: Radius.circular(20.r * 2)),
          color: Theme.of(context).colorScheme.surface,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(
                  top: 20.h, bottom: 20.h, left: 20.w, right: 20.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: Theme.of(context).colorScheme.background),
              child: BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  if (state is CartHasProduct) {
                    return Text(
                      '${state.cart.subTotalString}\$00',
                      style: TextStyle(fontSize: 24.sp),
                    );
                  } else {
                    return Center(
                      child: Text('Algo deu errado!!'),
                    );
                  }
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: 20.h, bottom: 20.h, left: 20.w, right: 20.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: Theme.of(context).colorScheme.primary),
              child: Text(
                'Finalizar Compra',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.apply(color: Colors.white70),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BuildCartItems extends StatelessWidget {
  const BuildCartItems(
      {super.key, required this.product, required this.quantity});
  final Product product;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140.h,
      width: double.maxFinite,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10.h),
            width: 140.r,
            height: 140.r,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: Colors.white,
                image: DecorationImage(
                    image: NetworkImage(product.imageUrl.toString()),
                    fit: BoxFit.cover)),
          ),
          Expanded(
            child: Container(
              height: 100.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.r),
                    bottomRight: Radius.circular(20.r)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(product.name,
                      style: Theme.of(context).textTheme.headlineSmall),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${product.price}\$',
                          style: Theme.of(context).textTheme.headlineSmall),
                      Container(
                        padding: EdgeInsets.only(
                            top: 10.h, bottom: 10.h, left: 10.w, right: 10.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            color: Theme.of(context).colorScheme.primary),
                        child: Row(children: [
                          GestureDetector(
                            onTap: () {
                              context
                                  .read<CartBloc>()
                                  .add(RemoveProductFromCart(product));
                            },
                            child: const Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            "$quantity",
                            style: TextStyle(
                              fontSize: 24.sp,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          GestureDetector(
                              onTap: () {
                                context
                                    .read<CartBloc>()
                                    .add(AddProductToCart(product));
                              },
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                              )),
                        ]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
