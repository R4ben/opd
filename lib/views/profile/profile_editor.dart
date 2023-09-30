import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileEditorPage extends StatelessWidget {
  const ProfileEditorPage({
    super.key,
    required this.title,
    required this.widgets, required this.onPressed,
  });
  final String title;
  final List<Widget> widgets;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
		    appBar: AppBar(
			    actions: [IconButton(onPressed: onPressed, icon: Icon(Icons.done_outlined))],
        title: Text(title, style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.white)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        child: SafeArea(
          child: Column(
            children: [
	    ...widgets,
            ],
          ),
        ),
      ),
    );
  }
}
