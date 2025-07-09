import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_pro/bloc/auth/auth_bloc.dart';
import 'package:map_pro/bloc/auth/auth_event.dart';
import 'package:map_pro/bloc/user/user_bloc.dart';
import 'package:map_pro/bloc/user/user_event.dart';
import 'package:map_pro/model/category_model.dart';


class HomeController
{
  final BuildContext context;

  List<CategoryModel>   mockCategories =
   [
     CategoryModel(
       route: 'qrCode',
       title: 'Chat',
       icon: Icons.chat,
     ),
     CategoryModel(
       route: 'location',
       title: 'Location',
       icon: Icons.map,
     ),
     CategoryModel(
       route: 'profile',
       title: 'Profile',
       icon: Icons.account_circle,
     ),
     CategoryModel(
       route: 'language',
       title: 'Language',
       icon: Icons.language,
     ),
   ];
   HomeController(this.context,);
   void getUser()
   {

    context.read<UserBloc>().add(LoadUserById());

   }
  void logOut()
  {
    context.read<UserBloc>().add(LogoutRequested());
  }
}
