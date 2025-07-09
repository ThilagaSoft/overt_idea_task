import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:map_pro/bloc/auth/auth_bloc.dart';
import 'package:map_pro/bloc/auth/passwordVisibilityCubit.dart';
import 'package:map_pro/bloc/chat/chant_qr_screen_cubit.dart';
import 'package:map_pro/bloc/chat/chat_bloc.dart';
import 'package:map_pro/bloc/country/country_bloc.dart';
import 'package:map_pro/bloc/language/language_bloc.dart';
import 'package:map_pro/bloc/language/language_event.dart';
import 'package:map_pro/bloc/location/map_bloc.dart';
import 'package:map_pro/bloc/user/user_bloc.dart';
import 'package:map_pro/controller/language_controller.dart';
import 'package:map_pro/repository/auth_repository.dart';
import 'package:map_pro/repository/chat_repository.dart';
import 'package:map_pro/repository/firebe_repository.dart';
import 'package:map_pro/repository/language_reository.dart';
import '../repository/home_repository.dart';


class CommonBlocProvider extends StatelessWidget {
  final Widget child;

  const CommonBlocProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:
      [
        BlocProvider(create: (_) => AuthBloc(authRepository: AuthRepository())),
        BlocProvider(create: (_) => PasswordVisibilityCubit()),
       BlocProvider(create: (_) => ChatBloc(firebaseRepository: FirebaseRepository(), chatRepository: ChatRepository())),
        BlocProvider(create: (_) => UserBloc(homeRepository: HomeRepository())),
        BlocProvider(create: (_) => LanguageBloc(LanguageController(LanguageRepository()))..add(LoadLanguages()),),
        BlocProvider(create: (_) => CountryBloc()),
        BlocProvider(create: (_) => MapBloc()..startLocationUpdates()),
       BlocProvider(create: (_) => QrViewCubit()),

      ],
      child: child,
    );
  }
}

