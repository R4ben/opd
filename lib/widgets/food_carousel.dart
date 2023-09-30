import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../../model/models.dart';
import '../bloc/bloc.dart';

class FoodCarousel extends StatefulWidget {
  const FoodCarousel({super.key});

  @override
  State<FoodCarousel> createState() => _FoodCarouselState();
}

class _FoodCarouselState extends State<FoodCarousel> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPagevalue = 0.0;
  final double _scaleFactor = 0.8;
  final double _heigh = 220.h;
  @override
  void initState() {
    pageController.addListener(() {
      setState(() {
        _currPagevalue = pageController.page!;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantBloc, RestaurantState>(
      builder: (context, state) {
        if (state is RestaurantLoaded) {
          return Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 25.w, right: 15.w, bottom: 15.h),
                width: double.maxFinite,
                child: Text(
                  'O que vai comer hoje?',
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 320.h,
                child: PageView.builder(
                    controller: pageController,
                    itemCount: state.restaurant.length,
                    itemBuilder: (context, position) {
                      return _buildPageItem(
                          position, context, state.restaurant[position]);
                    }),
              ),

              DotsIndicator(
                dotsCount: state.restaurant.length,
                position: _currPagevalue.floor(),
                decorator: DotsDecorator(
                  size: const Size.square(9.0),
                  activeSize: const Size(18.0, 9.0),
                  activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              ),

              Container(
                margin: EdgeInsets.only(left: 30.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Mais Pedidos',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    SizedBox(width: 10.w),
                    Container(
                        child: Text('.',
                            style: Theme.of(context).textTheme.displayMedium)),
                    SizedBox(width: 10.w),
                    Container(
                      margin: EdgeInsets.only(bottom: 2.h),
                      child: Text(
                        'da semana',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              ),
              //List of food
              _builbFoodList(),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _builbFoodList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 10.h),
          child: Row(
            children: [
              Container(
                width: 120.h,
                height: 120.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: Colors.white,
                  image: const DecorationImage(
                      image: AssetImage('assets/sc.png'), fit: BoxFit.cover),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Comide',
                            style: Theme.of(context).textTheme.headlineLarge),
                        SizedBox(height: 10.h),
                        Text('Alguma Caracteristica',
                            style: Theme.of(context).textTheme.bodySmall),
                        SizedBox(height: 10.h),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconAndText(
                              icon: Icons.circle,
                              iconColor: Colors.amber,
                              text: 'Normal',
                            ),
                            IconAndText(
                              icon: Icons.location_on,
                              iconColor: Colors.green,
                              text: '1.5Km',
                            ),
                            IconAndText(
                              icon: Icons.access_time_rounded,
                              iconColor: Colors.amber,
                              text: 'Normal',
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
        );
      },
    );
  }

  Widget _buildPageItem(
      int index, BuildContext context, Restaurant restaurant) {
    Matrix4 matrix = Matrix4.identity();
    if (index == _currPagevalue.floor()) {
      var currScale = 1 - (_currPagevalue - index) * (1 - _scaleFactor);
      var currTrans = _heigh * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPagevalue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPagevalue - index + 1) * (1 - _scaleFactor);
      var currTrans = _heigh * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPagevalue.floor() - 1) {
      var currScale = 1 - (_currPagevalue - index) * (1 - _scaleFactor);
      var currTrans = _heigh * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _heigh * (1 - _scaleFactor) / 2, 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => context
                .read<NavigationBloc>()
                .add(NavigateToRecommendeFoodDetails(restaurant: restaurant)),
            child: Container(
              height: _heigh,
              margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 2.h),
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(restaurant.imageUrl.toString())),
                borderRadius: BorderRadius.circular(30.r),
                // color: Theme.of(context).colorScheme.secondary
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 160.h,
              margin: EdgeInsets.only(left: 30.w, right: 30.w, bottom: 10.h),
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                        color: Color(0xFFe8e8e8),
                        blurRadius: 3.0,
                        offset: Offset(0, 5)),
                    BoxShadow(
                        color: Color(0xFFe8e8e8),
                        blurRadius: 2.0,
                        offset: Offset(-2, 0)),
                    BoxShadow(
                        color: Color(0xFFe8e8e8),
                        blurRadius: 2.0,
                        offset: Offset(2, 0)),
                  ],
                  borderRadius: BorderRadius.circular(20.r),
                  color: Theme.of(context).colorScheme.background),
              child: Container(
                padding: EdgeInsets.only(top: 15.h, left: 15.w, right: 15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(restaurant.name.toString(),
                        style: Theme.of(context).textTheme.displayMedium),
                    //SizedBox(height: 6.h),
                    Text(restaurant.slogan.toString(),
                        style: Theme.of(context).textTheme.bodySmall),
                    //SizedBox(height: 5.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ButtonIcon(
                          scheme: 'tel',
                          icon: Icons.phone_outlined,
                          path: restaurant.phone.toString(),
                        ),
                        ButtonIcon(
                          text: '14km',
                          scheme: 'tel',
                          icon: Icons.location_on,
                          path: restaurant.phone.toString(),
                          color: Colors.orange,
                        ),
                        // IconAndText(
                        //   icon: Icons.location_on,
                        //   iconColor: Colors.orange,
                        //   text: 'Normal',
                        // ),
                        ButtonIcon(
                          scheme: 'mailto',
                          icon: Icons.mail_outlined,
                          path: restaurant.mail.toString(),
                          color: Theme.of(context).colorScheme.error,
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
    );
  }
}
