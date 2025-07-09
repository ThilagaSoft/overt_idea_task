import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:map_pro/utility/common_extension.dart';
import 'package:map_pro/utility/config/static_text.dart';
import 'package:map_pro/utility/theme/app_color.dart';
import 'package:map_pro/utility/theme/text_styles.dart';
import 'package:map_pro/view/widgets/button_widget.dart';

Future<void> showSuccessDialog(BuildContext context, String message,VoidCallback onNav) async {
  final currentLocale = context.currentLocale;

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {

      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children:
          [
            Icon(Icons.check_circle,color: AppColors.green,size: 100,),
            SizedBox(height: 16),
            Text(
              message,
              style: TextStyles.boldText,
            ),
            SizedBox(height: 20),
            ButtonWidget(buttonText: message.contains('Login')? "${StaticText.goToHome.tr()}":"${StaticText.goToLogin.tr()}", onSubmit:onNav)
          ],
        ),
      );
    },
  );
}
