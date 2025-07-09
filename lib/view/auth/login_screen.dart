import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_pro/bloc/auth/auth_bloc.dart';
import 'package:map_pro/bloc/auth/auth_state.dart';
import 'package:map_pro/controller/auth_controller.dart';
import 'package:map_pro/bloc/auth/passwordVisibilityCubit.dart';
import 'package:map_pro/utility/common_extension.dart';
import 'package:map_pro/utility/config/static_text.dart';
import 'package:map_pro/utility/theme/text_styles.dart';
import 'package:map_pro/view/widgets/button_widget.dart';
import 'package:map_pro/view/widgets/common_loading.dart';
import 'package:map_pro/view/widgets/passwordField_widget.dart';
import 'package:map_pro/view/widgets/successful_dialogbox.dart';
import 'package:map_pro/view/widgets/textformfield_widget.dart';
class LoginScreen extends StatelessWidget {
final AuthController authController;
  const LoginScreen({
    super.key, required this.authController
  });
  @override
  Widget build(BuildContext context)
  {
    final currentLocale = context.currentLocale;

    return WillPopScope(
      onWillPop: ()
      async{
        return false;
      },
      child: Scaffold(
          backgroundColor: Colors.purple,
          body: SafeArea(
              child: MultiBlocListener(listeners:
              [
              BlocListener<AuthBloc,AuthState>(listener:(context, state)
              {
              if (state is AuthLoading)
                {
                  LoadingDialog.show(context, "Loading");
                }
              else if (state is LoginSuccess)
              {
                LoadingDialog.hide(context);
                Future.microtask(()
                {
                  showSuccessDialog(context, StaticText.loginSuccess, ()
                  {
                    Navigator.pushReplacementNamed(context, '/home');
                  });
                });
                // showSuccessDialog(context, "Login Success", () {Navigator.pushNamed(context, '/home');});
              }
              else if (state is AuthError)
              {
                LoadingDialog.hide(context);

              ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message.replaceFirst("Exception: ", ""))),
              );
              }

              }),
            ],
                child: Container(
                  color: Colors.purple, // This ensures full background
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
                                    StaticText.login.tr(),
                                    style: TextStyles.heading,
                                  ),
                                  const SizedBox(height: 24),
                                  TextFormFieldWidget(
                                    controller: authController.emailController,
                                    hintText: 'Email',
                                    prefixIcon: const Icon(Icons.email),
                                    focusNode: authController.emailFocus,
                                  ),
                                  const SizedBox(height: 20),
                                  BlocSelector<PasswordVisibilityCubit, Map<String, bool>, bool>(
                                      selector: (state) => state["Password"] ?? true,
                                      builder: (context, obscure) {
                                      return PasswordFieldWidget(
                                        controller: authController.passwordController,
                                        hintText: 'Password',
                                        obscurePassword: obscure,
                                        onChanged: ()
                                        {
                                          authController.passwordShowHide("Password");
                                        },
                                        focusNode: authController.passwordFocus,


                                      );
                                    }
                                  ),
                                  const SizedBox(height: 24),
                                  ButtonWidget(buttonText: StaticText.login.tr(),
                                  onSubmit: ()
                                  {
                                    authController.login();

                                  },
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children:
                                    [
                                      Text(StaticText.notHaveAccount.tr(),style: TextStyles.smallHintText,),
                                      TextButton(
                                          onPressed: ()
                                          {
                                            Navigator.pushReplacementNamed(context, '/register');

                                          },
                                          child: Text(StaticText.register.tr(),style: TextStyles.smallHintButtonText,))
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
            )

      ),
    );
  }
}


