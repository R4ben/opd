import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../model/models.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 10.h),
      child: GestureDetector(
        onTap: () => context.push('/productPage/${product.id}'),
        child: Row(
          children: [
            Container(
              width: 120.h,
              height: 120.h,
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
                height: 100.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20.r),
                      topRight: Radius.circular(20.r)),
                  color: Colors.white,
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
                      Text('${product.price}\$00',
                          style: Theme.of(context).textTheme.headlineSmall),
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
