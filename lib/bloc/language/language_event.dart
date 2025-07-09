import 'package:map_pro/model/language_model.dart';

abstract class LanguageEvent {}

class LoadLanguages extends LanguageEvent {}

class SelectLanguage extends LanguageEvent {
  final LanguageModel selectedLanguage;

  SelectLanguage(this.selectedLanguage);
}
