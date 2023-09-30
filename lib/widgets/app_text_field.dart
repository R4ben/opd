import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final IconData icon;
  final String? Function(String?) validator;
  final void Function(String)? onChanged;
  final bool isObscure;
  const AppTextField(
      {super.key,
      required this.textController,
      required this.hintText,
      required this.icon,
      required this.validator,
      required this.onChanged,
      this.isObscure = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 1.0,
                spreadRadius: 5,
                offset: const Offset(0, 5),
                color: Colors.grey.withOpacity(0.2)),
          ],
          borderRadius: BorderRadius.circular(100.r)),
      child: TextFormField(
        obscureText: isObscure,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100.r),
              borderSide: const BorderSide(width: 1.0, color: Colors.white)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100.r),
              borderSide: const BorderSide(width: 1.0, color: Colors.white)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100.r),
          ),
          hintText: hintText,
        ),
        validator: validator,
        onChanged: onChanged,
      ),
    );
  }
}
