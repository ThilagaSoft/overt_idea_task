import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_pro/bloc/user/user_event.dart';
import 'package:map_pro/bloc/user/user_state.dart';
import 'package:map_pro/model/user_model.dart';
import 'package:map_pro/repository/home_repository.dart';

class UserBloc extends Bloc<UserEvent, UserState>
{
  final HomeRepository homeRepository;

  UserBloc({required this.homeRepository}) : super(UserInitial())
  {
    on<LoadUserById>(getUser);
    on<LogoutRequested>(logOut);

  }

  Future<UserModel?> getUser(LoadUserById event, Emitter<UserState> emit) async
  {
    emit(UserLoading());
    try {
      final user = await homeRepository.getUserDetails();

      emit(UserLoaded(user!));
    }
    on SocketException
    {
      emit(UserError("No internet connection"));
    }
    on Exception catch (e)
    {
      emit(UserError(e.toString()));
    }
    catch (e, stackTrace)
    {
      print(" Unexpected Login error: $e\n$stackTrace");
      emit(UserError("Something went wrong"));
    }
    return null;
  }

  void logOut(LogoutRequested event, Emitter<UserState> emit) async
  {
    try
    {
      emit(UserLogoutLoading());
      await homeRepository.logout();
      emit(LogOutState());
    }
    catch(e)
    {
      emit(UserError(e.toString()));
    }

  }



}
