import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:map_pro/model/user_model.dart';
import 'package:map_pro/utility/theme/app_color.dart';
import 'package:map_pro/utility/common_extension.dart';
import 'package:map_pro/view/widgets/image_network_widget.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget
{
  final String title;
  final bool backButton;
  final UserModel? userData;

  const CommonAppBar({super.key, required this.title, required this.backButton, this.userData});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final currentLocale = context.currentLocale;
    return AppBar(
      backgroundColor: AppColors.primary,
      centerTitle: true,
      title: userData !=null?
        Text(
          title.tr()+" ${capitalize(userData!.userName)}",
        style: const TextStyle(color: AppColors.white),
      ) :    Text(
          title.tr()+"",
        style: const TextStyle(color: AppColors.white),
      ),
      leading:backButton?
      InkWell(
        onTap: ()
          {
            if(title.toLowerCase() == "chat screen")
              {
                Navigator.pushReplacementNamed(context, "/qrCode");
              }
            else
              {
                Navigator.pushReplacementNamed(context, "/home");

              }
          },
          child: Icon(Icons.arrow_back_ios, color: AppColors.white,size: 30,)):
      Icon(Icons.person_pin, color: AppColors.white,size: 30,),
      actions:
      [
        if (userData?.countryData.flag.png != null)
          Padding(
            padding:const  EdgeInsets.only(right: 8.0,left: 8.0),
            child: ImageNetworkWidget(
              image: userData!.countryData.flag.png,
              height: 20,
              width: 30,
            ),
          ),

      ],

    );

  }

}
