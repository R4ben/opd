import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../model/models.dart';

class ProductCarousel extends StatefulWidget {
  final List<CategoryModel> category;
  const ProductCarousel({super.key, required this.category});

  @override
  State<ProductCarousel> createState() => _ProductCarouselState();
}

class _ProductCarouselState extends State<ProductCarousel> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPagevalue = 0.0;
  final double _scaleFactor = 0.8;
  final double _heigh = 220.h;
  final List<CategoryModel> cate = CategoryModel.categories;
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
    return Column(
      children: [
        SizedBox(
          height: 320.h,
          child: PageView.builder(
              controller: pageController,
              itemCount: widget.category.length,
              itemBuilder: (context, position) {
                return _buildItemSlide(
                    position, context, widget.category[position]);
              }),
        ),
        DotsIndicator(
          dotsCount: widget.category.length,
          position: _currPagevalue.floor(),
          decorator: DotsDecorator(
            activeColor: Theme.of(context).colorScheme.primary,
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
          ),
        ),
      ],
    );
  }

  Widget _buildItemSlide(
      int index, BuildContext context, CategoryModel category) {
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
            onTap: () {},
            child: Container(
              height: _heigh,
              margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 2.h),
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(category.imageUrl.toString()),),
                borderRadius: BorderRadius.circular(30.r),
                // color: Theme.of(context).colorScheme.secondary
              ),
              child: Text(category.name),
            ),
          ),
        ],
      ),
    );
  }
}
