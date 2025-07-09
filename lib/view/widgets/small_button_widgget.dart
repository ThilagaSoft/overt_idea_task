import 'package:flutter/material.dart';
import 'package:map_pro/utility/theme/text_styles.dart';

class SmallButtonWidget extends StatelessWidget {
  String buttonText;
  VoidCallback onSubmit;
  SmallButtonWidget({super.key, required this.buttonText, required this.onSubmit});

  @override
  Widget build(BuildContext context)
  {
    return SizedBox(
      height: 35,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onSubmit,
        style: ElevatedButton.styleFrom(

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child:  Text(buttonText,style: TextStyles.smallButtonText,),
      ),
    );
  }
}
