import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../bloc/bloc.dart';
import 'widgets.dart';

class ListCategories extends StatelessWidget {
  const ListCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is CategoryLoaded) {
          return GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.h,
                mainAxisSpacing: 10.h),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.categories.length,
            itemBuilder: (context, index) {
              return CategoryTile(
                category: state.categories[index],
                key: ValueKey(state.categories[index].id),
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
