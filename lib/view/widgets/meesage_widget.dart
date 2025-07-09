import 'package:flutter/material.dart';
import 'package:map_pro/utility/theme/app_color.dart';

class MessageWidget extends StatelessWidget
{
  String message;
   MessageWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context)
  {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
              color: AppColors.primary.withOpacity(0.1),
          )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline,color: AppColors.primary,),
          SizedBox(width: 8,),
          Expanded(child: Text(message,style: TextStyle(color: AppColors.primary,),textAlign: TextAlign.justify,)),
        ],
      )
    );
  }
}
