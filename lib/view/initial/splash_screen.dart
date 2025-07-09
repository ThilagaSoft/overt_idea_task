import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:map_pro/utility/theme/app_color.dart';

class SplashScreen extends StatelessWidget
{
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child:Image.asset(
            'assets/image/welcome.png',
            fit: BoxFit.contain,
            color: AppColors.white,
            errorBuilder: (context, error, stackTrace) {
              return Icon(Icons.image,color: AppColors.boxShade,);
            },
          )

        ),
      ),
    );
  }
}
