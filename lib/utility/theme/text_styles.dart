import 'package:flutter/material.dart';
import 'package:map_pro/utility/theme/app_color.dart';

class TextStyles
{
  static const TextStyle heading = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle boldText = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

  static const TextStyle buttonText = TextStyle(
    color: AppColors.white,
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle smallText = TextStyle(
    color: AppColors.black,
    fontSize: 14,
  );

  static const TextStyle smallButtonText = TextStyle(
    color: AppColors.white,
    fontSize: 14,
  );

  static const TextStyle hint = TextStyle(
    color: AppColors.grey,
  );

  static const TextStyle  smallHintText = TextStyle(color: AppColors.black, fontSize: 16);
  static const TextStyle  smallHintButtonText = TextStyle(color: AppColors.primary, fontSize: 16,fontWeight: FontWeight.bold);
  static const EdgeInsets padding = EdgeInsets.symmetric(vertical: 14);
}
