import 'package:flutter/material.dart';
import 'package:map_pro/utility/theme/text_styles.dart';

class ButtonWidget extends StatelessWidget {
  String buttonText;
  VoidCallback onSubmit;
   ButtonWidget({super.key, required this.buttonText, required this.onSubmit});

  @override
  Widget build(BuildContext context)
  {
    return SizedBox(
      height: 45,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onSubmit,
        style: ElevatedButton.styleFrom(

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child:  Text(buttonText,style: TextStyles.buttonText,),
      ),
    );
  }
}
