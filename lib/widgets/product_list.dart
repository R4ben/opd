import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../bloc/bloc.dart';
import 'product_tile.dart';

class ListProducts extends StatelessWidget {
  const ListProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return Center(
              child: Padding(
            padding: EdgeInsets.symmetric(vertical: 100.h),
            child: const CircularProgressIndicator(),
          ));
        }
        if (state is ProductLoaded) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.products.length,
            itemBuilder: (context, index) {
              return ProductTile(
                key: ValueKey(state.products[index].id),
                product: state.products[index],
              );
            },
          );
        } else {
          return const Center(child: Text('Algo deu errado tente mais tarde'));
        }
      },
    );
  }
}
