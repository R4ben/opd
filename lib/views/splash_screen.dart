import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../bloc/navigation/navigation_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;

  late AnimationController _animationController;
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..forward();
    animation =
        CurvedAnimation(parent: _animationController, curve: Curves.linear);
    Timer(const Duration(seconds: 3),
        () => context.read<NavigationBloc>().add(NavigateToMainPage()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        ScaleTransition(
            scale: animation,
            child: Center(
                child:
                    Image.asset('assets/OnPointDelivery.png', width: 250.w))),
      ]),
    );
  }
}
