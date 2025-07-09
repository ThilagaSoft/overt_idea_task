import 'package:flutter/material.dart';
import 'package:map_pro/bloc/auth/auth_event.dart';
import 'package:map_pro/bloc/auth/passwordVisibilityCubit.dart';
import 'package:map_pro/model/country_model.dart';
import '../bloc/auth/auth_bloc.dart';

class AuthController
{
  final AuthBloc authBloc;
  final PasswordVisibilityCubit passwordVisibilityCubit;
  AuthController({required this.authBloc,required this.passwordVisibilityCubit});

  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final userNameFocus = FocusNode();
  final emailFocus  = FocusNode();
  final mobileFocus  = FocusNode();
  final passwordFocus  = FocusNode();
  final newPasswordFocus  = FocusNode();
  final confirmPasswordFocus  = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey();

  final ValueNotifier<Country?> selectedCountry = ValueNotifier<Country?>(null);

  void register()
 async{
    if(formKey.currentState!.validate())
      {
       await unFocus();
      authBloc.add(RegisterEvent(
              userName: userNameController.text,
              email: emailController.text,
              phone: mobileController.text,
              password: newPasswordController.text,
              countryData: selectedCountry.value!,
            ));

      }

  }

  void login()
  async{
    await unFocus();
    if(formKey.currentState!.validate())
      {
        unFocus();
        authBloc.add(LoginEvent(
            email: emailController.text,
            password: passwordController.text
        ));

      }

  }
  void selectedCountryData(Country country)
  {
    selectedCountry.value = country;
  }
  void passwordShowHide(String fieldKey)
  {
   passwordVisibilityCubit.toggle(fieldKey);

  }
  Future<void>  unFocus()
  async {
    userNameFocus.unfocus();
    emailFocus.unfocus();
    passwordFocus.unfocus();
    confirmPasswordFocus.unfocus();
    mobileFocus.unfocus();
    newPasswordFocus.unfocus();
    confirmPasswordFocus.unfocus();

  }

}
