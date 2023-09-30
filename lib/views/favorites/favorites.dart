import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:on_point_delivery/bloc/bloc.dart';
import 'package:on_point_delivery/model/product_model.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Lista de Desejo',
        style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.white),
      )),
      body:
          BlocBuilder<FavoritesBloc, FavoritesState>(builder: (context, state) {
        if (state is FavoreitesLoaded) {
          List<Product> products = state.products;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index) {
                  return FavoriteTile(product: products[index]);
                },
              ),
            ),
          );
        } else {
          return Center(
            child: Text('Nada'),
          );
        }
      }),
    );
  }
}

class FavoriteTile extends StatelessWidget {
	const FavoriteTile({super.key, required this.product});
final Product product;
	@override
	Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      child: GestureDetector(
        onTap: (){},// => context.push('/productPage/${product.id}'),
        child: Row(
          children: [
            Container(
              width: 150.h,
              height: 150.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: Colors.white,
                image: DecorationImage(
                    image: CachedNetworkImageProvider(product.imageUrl,
                        maxHeight: 120.h.floor(), maxWidth: 120.h.floor()),
                    fit: BoxFit.cover),
              ),
            ),
            Expanded(
              child: Container(
                height: 120.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20.r),
                      topRight: Radius.circular(20.r)),
                  color: Colors.white70,
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 10.w, right: 10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(product.name,
                          style: Theme.of(context).textTheme.labelLarge),
                      product.shortDescription.isEmpty
                          ? const SizedBox()
                          : Text(
                              product.shortDescription,
                              style: Theme.of(context).textTheme.bodySmall,
                              overflow: TextOverflow.clip,
                            ),
                      Row(
			mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${product.price}\$00',
                              style: Theme.of(context).textTheme.headlineSmall),
                          Row(
                            children: [
                              IconButton(
			      	iconSize: 30.r,
                                  onPressed: () => context
                                      .read<FavoritesBloc>()
                                      .add(DislikeProduct(product: product)),
                                  icon: Icon(Icons.delete_outlined)),
                              IconButton(
			      	iconSize: 30.r,
                                  onPressed: () {},
                                  icon: Icon(Icons.add_shopping_cart_outlined))
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
	}
}
