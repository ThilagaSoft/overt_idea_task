import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_pro/bloc/language/language_event.dart';
import 'package:map_pro/bloc/language/language_state.dart';
import 'package:map_pro/controller/language_controller.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final LanguageController controller;

  LanguageBloc(this.controller)
      : super(LanguageState(languages: [])) {
    on<LoadLanguages>((event, emit) {
      final langs = controller.getLanguages();
      emit(state.copyWith(languages: langs));
    });

    on<SelectLanguage>((event, emit) {
      emit(state.copyWith(selectedLanguage: event.selectedLanguage));
    });
  }
}
