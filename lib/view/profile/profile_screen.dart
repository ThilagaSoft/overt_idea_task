import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_pro/bloc/user/user_bloc.dart';
import 'package:map_pro/bloc/user/user_event.dart';
import 'package:map_pro/bloc/user/user_state.dart';
import 'package:map_pro/controller/home_controller.dart';
import 'package:map_pro/repository/home_repository.dart';
import 'package:map_pro/utility/common_extension.dart';
import 'package:map_pro/utility/config/static_text.dart';
import 'package:map_pro/utility/theme/app_color.dart';
import 'package:map_pro/utility/theme/text_styles.dart';
import 'package:map_pro/view/widgets/common_appBar.dart';
import 'package:map_pro/view/widgets/common_loading.dart';
import 'package:map_pro/view/widgets/image_network_widget.dart';
import 'package:map_pro/view/widgets/logout_dialog_widget.dart';
import 'package:shimmer/shimmer.dart';

class ProfileScreen extends StatelessWidget
{

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context)
  {
    final currentLocale = context.currentLocale;

    return WillPopScope(
      onWillPop: ()async
      {
        return false;
      },
      child: BlocProvider<UserBloc>(
            create: (_) => UserBloc(homeRepository: HomeRepository())..add(LoadUserById()),
            child: Scaffold(
              appBar: CommonAppBar(title: StaticText.profile, backButton: true),
              body: BlocListener<UserBloc, UserState>(
                listener: (context,state)
                {
                  if(state is UserLogoutLoading)
                    {

                      LoadingDialog.show(context, "Loading");
                    }
                  if(state is LogOutState)
                    {
                      print("kjjkhjkhjkhkjjkhk");
                      LoadingDialog.hide(context);
                      Navigator.pushReplacementNamed(context, '/login');
                    }
                },
                child: BlocBuilder<UserBloc, UserState>(
                builder: (context, state)
                         {
                 if(state is UserLoaded)
                   {
                     return Center(
                       child: Padding(
                         padding: const EdgeInsets.all(16),
                         child: Card(
                           color: AppColors.white,
                           elevation: 6,
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(16),
                           ),
                           child: Column(
                             mainAxisSize: MainAxisSize.min,
                             crossAxisAlignment: CrossAxisAlignment.center,
                             children:
                             [
                               const SizedBox(height: 50),

                               Container(
                                 height: 80,
                                 width: 80,
                                 decoration: BoxDecoration(
                                     color: AppColors.primary,
                                     borderRadius: BorderRadius.circular(100),
                                     border: Border.all(
                                         color: AppColors.primary
                                     )
                                 ),
                                 child: Icon(Icons.person,color: AppColors.white,size: 80,),
                               ),
                               SizedBox(height: 15,),
                               Text(capitalize(state.user.userName),style: TextStyles.heading,),
                               ListTile(
                                 title: Text(state.user.email,style: TextStyles.smallHintText,),
                                 leading: Icon(Icons.email,color: AppColors.red,),

                               ),
                               Divider(color: AppColors.boxShade,),
                               ListTile(
                                 title: Text(state.user.mobile,style: TextStyles.smallHintText,),
                                 leading: Icon(Icons.phone,color: AppColors.green,),
                               ),
                               Divider(color: AppColors.boxShade,),


                               ListTile(
                                 title: Text(state.user.countryData.name.common,style: TextStyles.smallHintText,),
                                 leading: ImageNetworkWidget(image: state.user.countryData.flag.png, height: 20, width: 30,),

                               ),
                               Divider(color: AppColors.boxShade,),

                               ListTile(
                                 onTap: ()
                                 {
                                   Navigator.pushNamed(context, '/language');
                                 },
                                 title: Text(StaticText.language.tr(),style: TextStyles.smallHintText,),
                                 leading: Icon(Icons.language,color: AppColors.blue,),
                                 trailing: Icon(Icons.arrow_forward_ios,color: AppColors.boxShade,),

                               ),
                               Divider(color: AppColors.boxShade,),

                               ListTile(
                                 onTap: ()
                                 {
                                   showLogoutDialog(context);
                                   // homeController.logOut();
                                 },
                                 title: Text(StaticText.logOut.tr(),style: TextStyles.smallHintText,),
                                 leading: Icon(Icons.logout,color: AppColors.red,),
                                 trailing: Icon(Icons.arrow_forward_ios,color: AppColors.boxShade,),

                               ),

                               const SizedBox(height: 30),

                             ],
                           ),
                         ),
                       ),
                     );

                   }
                 else
                   {
                     return Center(
                       child: Padding(
                         padding: const EdgeInsets.all(16),
                         child: Card(
                           color: AppColors.white,
                           elevation: 6,
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(16),
                           ),
                           child: Shimmer.fromColors(
                             baseColor: Colors.grey[300]!,
                             highlightColor: Colors.grey[100]!,
                             child: Column(
                               mainAxisSize: MainAxisSize.min,
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                                 const SizedBox(height: 50),
                                 Container(
                                   height: 80,
                                   width: 80,
                                   decoration: BoxDecoration(
                                     color: Colors.white,
                                     borderRadius: BorderRadius.circular(100),
                                   ),
                                 ),
                                 const SizedBox(height: 15),
                                 Container(height: 20, width: 100, color: Colors.white),
                                 const SizedBox(height: 15),
                                 ...List.generate(3, (index) => Column(
                                   children: [
                                     ListTile(
                                       leading: Container(
                                         height: 24,
                                         width: 24,
                                         color: Colors.white,
                                       ),
                                       title: Container(
                                         height: 16,
                                         width: double.infinity,
                                         color: Colors.white,
                                       ),
                                     ),
                                     Divider(color: AppColors.boxShade),
                                   ],
                                 )),
                                 const SizedBox(height: 30),
                               ],
                             ),
                           ),
                         ),
                       ),
                     );
                   }
                         }

                ),
              ),
            )
      ),
    );

  }

}
