import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:map_pro/controller/home_controller.dart';
import 'package:map_pro/utility/config/static_text.dart';
import 'package:map_pro/utility/common_extension.dart';
import 'package:map_pro/view/widgets/small_button_widgget.dart';

void showLogoutDialog(BuildContext context)
{
  final   homeController =  HomeController(context);

  final currentLocale = context.currentLocale;
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(StaticText.logOut.tr()),
          InkWell(
             onTap: ()
              {
                Navigator.pop(context);
              },
              child: Icon(Icons.clear))
        ],
      ),
      content: Padding(
        padding: const EdgeInsets.only(bottom: 10,top: 10),
        child: Text(StaticText.areYouSureLogout.tr()),
      ),
      actions:
      [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [

            Expanded(
              child: SmallButtonWidget(
              buttonText:StaticText.no.tr() ,
              onSubmit: ()
              {
                Navigator.pop(context);

              }),
            ),
            SizedBox(width: 50,),
            Expanded(
              child: SmallButtonWidget(
              buttonText:StaticText.yes.tr() ,
              onSubmit: ()
              {
                Navigator.pop(context);

                homeController.logOut();
              }),
            ),
          ],
         ),
      ],
    ),
  );
}
