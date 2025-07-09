import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_pro/bloc/auth/auth_state.dart';
import 'package:map_pro/bloc/country/country_bloc.dart';
import 'package:map_pro/bloc/country/country_event.dart';
import 'package:map_pro/bloc/country/country_state.dart';
import 'package:map_pro/controller/auth_controller.dart';
import 'package:map_pro/controller/country_controller.dart';
import 'package:map_pro/bloc/auth/auth_bloc.dart';
import 'package:map_pro/bloc/auth/passwordVisibilityCubit.dart';
import 'package:map_pro/model/country_model.dart';
import 'package:map_pro/utility/common_extension.dart';
import 'package:map_pro/utility/config/static_text.dart';
import 'package:map_pro/utility/theme/text_styles.dart';
import 'package:map_pro/view/widgets/button_widget.dart';
import 'package:map_pro/view/widgets/common_loading.dart';
import 'package:map_pro/view/widgets/dropDownField_widget.dart';
import 'package:map_pro/view/widgets/passwordField_widget.dart';
import 'package:map_pro/view/widgets/successful_dialogbox.dart';
import 'package:map_pro/view/widgets/textformfield_widget.dart';


class RegisterScreen extends StatelessWidget
{
  final AuthController authController;
  final CountryController countryController;

  const RegisterScreen({super.key, required this.authController, required this.countryController});
  @override
  Widget build(BuildContext context)
  {
    final currentLocale = context.currentLocale;

    return  BlocProvider<CountryBloc>(
      create: (_) => CountryBloc()..add(FetchCountries()),
      child:  WillPopScope(
          onWillPop: () async
          {
            return false;
          },
          child: Scaffold(
            backgroundColor: Colors.purple,
            body: SafeArea(
              child:MultiBlocListener(
                listeners:
                [
                BlocListener<AuthBloc, AuthState>(listener: (context, state)
                {
                  if (state is AuthLoading)
                  {
                    LoadingDialog.show(context, "Loading");
                  }
                  else if (state is RegisterSuccess)
                  {
                    LoadingDialog.hide(context);

                    showSuccessDialog(context, StaticText.registerSuccess, () {Navigator.pushNamed(context, '/login');});
                  }
                  else if (state is AuthError)
                  {
                    LoadingDialog.hide(context);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message.replaceFirst("Exception: ", ""))),
                    );
                  }
                }),
                BlocListener<CountryBloc, CountryState>(listener: (context, state)
                {
                  if (state is CountryLoaded)
                  {
                    LoadingDialog.hide(context);
                  }
                  else if (state is CountryLoading)
                  {
                    LoadingDialog.show(context, "Loading");
                  } else if (state is CountryError)
                  {
                    LoadingDialog.hide(context);
                    print(state.message);
                  }
                }),

              ],

                child: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Form(
                            key: authController.formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                 Text(
                                  StaticText.register.tr(),
                                  style: TextStyles.heading
                                ),
                                const SizedBox(height: 24),
                                TextFormFieldWidget(
                                  focusNode: authController.userNameFocus,
                                  controller: authController.userNameController,
                                  hintText: 'Username',
                                  prefixIcon: const Icon(Icons.person),
                                ),
                                const SizedBox(height: 20),
                                TextFormFieldWidget(
                                  focusNode: authController.emailFocus,
                                  controller: authController.emailController,
                                  hintText: 'Email',
                                  prefixIcon: const Icon(Icons.mail),
                                ),
                                const SizedBox(height: 20),
                                TextFormFieldWidget(
                                  focusNode: authController.mobileFocus,
                                  controller: authController.mobileController,
                                  hintText: 'Mobile',
                                  prefixIcon: const Icon(Icons.phone),
                                ),
                                const SizedBox(height: 20),
                                BlocBuilder<CountryBloc,CountryState>(
                                    builder: (context,state)
                                    {
                                      if(state is CountryLoaded)
                                      {
                                        final sortedList = [...state.countries]..sort((a, b) => a.name.common.compareTo(b.name.common));

                                        countryController.countriesList.value = sortedList;
                                        print("hjhkjhjhjkhjjhuy: ${state.countries[0].name.common}");
                                      }
                                      return ValueListenableBuilder<Country?>(
                                        valueListenable: authController.selectedCountry,
                                        builder: (context, selected, _) {
                                          return DropdownFieldWidget(
                                            value: selected,
                                            items: countryController.countriesList.value,
                                            hintText:"Select Country",
                                            onChanged: (country)
                                            {
                                              authController.selectedCountryData(country!);
                                            },
                                            validator: (value) => value == null ? 'Please select a country' : null,
                                          );
                                        },
                                      );
                                    }
                                ),
                                const SizedBox(height: 20),
                                 BlocSelector<PasswordVisibilityCubit, Map<String, bool>, bool>(
                                    selector: (state) => state["New Password"] ?? true,
                                    builder: (context, obscure) {
                                      return PasswordFieldWidget(
                                        focusNode: authController.newPasswordFocus,
                                        controller: authController.newPasswordController,
                                        hintText: 'Password',
                                        obscurePassword: obscure,
                                        onChanged: ()
                                        {
                                          authController.passwordShowHide('New Password');

                                        },
                                      );
                                    }
                                ),
                                const SizedBox(height: 20),
                                BlocSelector<PasswordVisibilityCubit, Map<String, bool>, bool>(
                                    selector: (state) => state["Confirm Password"] ?? true,
                                    builder: (context, obscure) {
                                      return PasswordFieldWidget(
                                        focusNode: authController.confirmPasswordFocus,
                                        controller: authController.confirmPasswordController,
                                        hintText: 'Confirm Password',
                                        obscurePassword: obscure,
                                        onChanged: ()
                                        {
                                          authController.passwordShowHide('Confirm Password');

                                        },
                                        validator: (value)
                                        {
                                          if (value == null || value.isEmpty)
                                          {
                                            return 'Please confirm your password';
                                          }
                                          if (value != authController.newPasswordController.text)
                                          {
                                            return 'Passwords do not match';
                                          }
                                          return null;
                                        },
                                      );
                                    }
                                ),

                                const SizedBox(height: 24),

                               ButtonWidget(
                                      buttonText: StaticText.register.tr(),
                                      onSubmit: ()
                                      {
                                        authController.register();

                                      },
                                    ),

                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    Text(
                                      StaticText.alreadyHaveAccount.tr(),
                                      style: TextStyles.smallHintText,
                                    ),
                                    TextButton(
                                      onPressed: ()
                                      {
                                        Navigator.pushNamed(context, '/login');

                                      },
                                      child: Text(
                                        StaticText.login.tr(),
                                        style: TextStyles.smallHintButtonText
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )),

    );
  }

}
