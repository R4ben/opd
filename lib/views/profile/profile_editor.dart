import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileEditorPage extends StatelessWidget {
  const ProfileEditorPage({
    super.key,
    required this.title,
    required this.label,
    required this.value,
    required this.field,
  });
  final String title;
  final String label;
  final String value;
  final String field;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: TextStyle(fontSize: 24.sp)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        child: SafeArea(
          child: Stack(
            children: [
              TextFormField(
                autofocus: true,
                initialValue: value,
                decoration: InputDecoration(
                  labelText: label,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("Guardar"),
                  style:
                      ElevatedButton.styleFrom(fixedSize: Size(0.8.sw, 40.h)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
