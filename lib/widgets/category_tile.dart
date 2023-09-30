import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../bloc/bloc.dart';
import '../model/models.dart';

class CategoryTile extends StatelessWidget {
  final CategoryModel category;
  const CategoryTile({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/categoryPage/${category.id}');
        context
            .read<ProductBloc>()
            .add(LoadProductsByCategory(categoryName: category.name));
      },
      child: Row(
        children: [
          Container(
            width: 177.w,
            height: 177.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              color: Colors.white,
              image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    category.imageUrl,
                    maxHeight: 177.w.floor(),
                    maxWidth: 177.w.floor(),
                  ),
                  fit: BoxFit.cover),
            ),
            child: Stack(children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 70.h,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      color:
                          Theme.of(context).colorScheme.primary.withAlpha(220)),
                  child: Center(
                    child: Text(
                      category.name,
                      style: Theme.of(context).textTheme.headlineMedium!.apply(
                          color: Theme.of(context).colorScheme.background),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
