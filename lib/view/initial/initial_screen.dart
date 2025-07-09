import 'package:flutter/material.dart';
import 'package:map_pro/controller/initial_controller.dart';
import 'package:map_pro/view/initial/splash_screen.dart';

class InitScreen extends StatelessWidget
{
  final InitController initController;

   const InitScreen({super.key, required this.initController});

  @override
  Widget build(BuildContext context)
  {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 5), () {
        initController.handleRedirection(context);
      });
    });
    return SplashScreen();
  }
}
