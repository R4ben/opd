import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/widgets.dart';

class AccountWidget extends StatelessWidget {
  final AppIcons appIcons;
  final String text;
  final Color color;
  const AccountWidget(
      {required this.appIcons,
      required this.text,
      super.key,
      this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        boxShadow: [
          BoxShadow(
              blurRadius: 1,
              offset: const Offset(0, 2),
              color: Colors.grey.withOpacity(0.2)),
        ],
      ),
      padding: EdgeInsets.only(
        left: 20.w,
        top: 10.h,
        bottom: 10.h,
      ),
      child: Row(
        children: [
          appIcons,
          SizedBox(width: 14.w),
          Text(text),
        ],
      ),
    );
  }
}
