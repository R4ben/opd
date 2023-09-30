import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:on_point_delivery/authenticator/session/session_bloc.dart';

import '../../model/models.dart';
import '../bloc/bloc.dart';
import '../widgets/app_icon.dart';

class ProductDetails extends StatelessWidget {
  final Product product;
  const ProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 90.h,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () => context.pop(),
                    child: const AppIcons(icon: Icons.clear)),
                GestureDetector(
                  onTap: () => context.push('/cartPage'),
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
                  product.name.toString(), //display product name
                  style: Theme.of(context).textTheme.bodyLarge,
                )),
              ),
            ),
            pinned: true,
            backgroundColor: Theme.of(context).colorScheme.primary,
            expandedHeight: 400.h,
            flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
              product.imageUrl.toString(),
              width: double.infinity,
              fit: BoxFit.cover,
            )),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 20.w, left: 20.w),
                  child: Column(
                    children: [
                      SizedBox(height: 10.h),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     IconAndText(
                      //       icon: Icons.phone_outlined,
                      //       iconColor: Theme.of(context).colorScheme.primary,
                      //       text: product.phone.toString(),
                      //     ),
                      //     IconAndText(
                      //       icon: Icons.location_on,
                      //       iconColor: Colors.green,
                      //       text: '1.5Km',
                      //     ),
                      //     IconAndText(
                      //       icon: Icons.mail_outline,
                      //       iconColor: Colors.amber,
                      //       text: product.mail.toString(),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                //Description
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20.r)),
                  margin: EdgeInsets.only(left: 20.w, right: 20.w),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Notas e Substituicoes'),
                        const Text('Em Caso queira um substituto'),
                        SizedBox(height: 20.h),
                        Text(
                          'Descrição',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          product.description,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ]),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Container(
          //   padding: EdgeInsets.only(
          //       left: 20.w * 2.5, right: 20.w * 2.5, top: 10.h, bottom: 10.h),
          //   child:
          // ),
          Container(
            height: 130.h,
            padding: EdgeInsets.only(
                top: 30.h, bottom: 30.h, left: 20.w, right: 20.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r * 2),
                  topRight: Radius.circular(20.r * 2)),
              color: Theme.of(context).colorScheme.surface,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Favorites
                BlocBuilder<SessionBloc, SessionState>(
                    builder: (context, state) {
                  if (state is Authenticated) {
                    return BlocBuilder<FavoritesBloc, FavoritesState>(
                        builder: (context, state) {
                      if (state is FavoreitesLoaded) {
                        if (state.products.contains(product)) {
                          return GestureDetector(
			  onTap: ()=>context.read<FavoritesBloc>().add(DislikeProduct(product:product)),
                            child: FavoriteButton(
                              color: Colors.red,
                            ),
                          );
                        } else {
                          return GestureDetector(
			  onTap: ()=>context.read<FavoritesBloc>().add(LikeProduct(product:product)),
                              child: FavoriteButton());
                        }
                      } else {
                        return GestureDetector(
			  onTap: ()=>context.read<FavoritesBloc>().add(LikeProduct(product:product)),
			child: FavoriteButton(color: Colors.black,));
                      }
                    });
                  } else {
                    return const FavoriteButton(color: Colors.blue,);
                  }
                }),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context
                              .read<CartBloc>()
                              .add(RemoveProductFromCart(product));
                        },
                        child: AppIcons(
                          iconColor: Theme.of(context).colorScheme.background,
                          icon: Icons.remove,
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          iconSize: 25.h,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 12.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            color: Theme.of(context).colorScheme.background),
                        child: BlocBuilder<CartBloc, CartState>(
                          builder: (context, state) {
                            if (state is CartHasProduct) {
                              var quantity = 0;
                              if (state.cart.products.isNotEmpty) {
                                quantity = state.cart
                                    .productQuantity(state.cart.products)
                                    .map((key, value) {
                                      if (key == product) {
                                        return MapEntry(key, value);
                                      } else {
                                        return const MapEntry(0, 0);
                                      }
                                    })
                                    .values
                                    .last;
                              }

                              return Text(
                                '${product.price}\$  X $quantity',
                                style: Theme.of(context).textTheme.bodyMedium,
                              );
                            } else {
                              return Text(
                                '${product.price}\$  X  0',
                                style: Theme.of(context).textTheme.bodyLarge,
                              );
                            }
                          },
                        ),
                      ),
                      SizedBox(width: 8.w),
                      GestureDetector(
                        onTap: () {
                          context
                              .read<CartBloc>()
                              .add(AddProductToCart(product));
                        },
                        child: AppIcons(
                          iconColor: Theme.of(context).colorScheme.background,
                          icon: Icons.add,
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          iconSize: 25.h,
                        ),
                      ),
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

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({super.key, this.color});
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(top: 20.h, bottom: 20.h, left: 20.w, right: 20.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: Theme.of(context).colorScheme.background),
      child: Icon(
        Icons.favorite,
        color: color ?? Theme.of(context).colorScheme.primary,
        size: 40.h,
      ),
    );
  }
}
