
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/widgets.dart';

class StorePage extends StatelessWidget{
const StorePage({super.key});
@override
Widget build(BuildContext context){
return SingleChildScrollView(
        child: Column(
          children: [
            //Header
            Container(
                margin: EdgeInsets.only(top: 45.h, bottom: 15.h),
                padding: EdgeInsets.only(right: 20.w, left: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Image.asset('assets/OnPointDelivery.png'),
                      ],
                    ),
                    Center(
                      child: Container(
                        width: 45.h,
                        height: 45.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            color: Theme.of(context).colorScheme.primary),
                        child: Icon(
                          Icons.search,
                          color: Theme.of(context).colorScheme.surface,
                        ),
                      ),
                    ),
                  ],
                )),

            // Expanded(child: SingleChildScrollView(child: FoodCarousel())),
            // _carousel(),
            const ListCategories(),
            SizedBox(height: 10.h)
          ],
        ),
      );
  }
  }
