import 'package:flutter/material.dart';
import 'package:map_pro/utility/theme/app_color.dart';

class LoadingDialog {
  static void show(BuildContext context, String? message) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent closing by tapping outside
      barrierColor: AppColors.transparent,
      builder: (context) {
        return Dialog(
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(

            borderRadius: BorderRadius.circular(12),


          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(width: 40),
                Flexible(
                  child: Text(
                    message ?? 'Loading...',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void hide(BuildContext context)
  {
      Navigator.pop(context);

  }
}
