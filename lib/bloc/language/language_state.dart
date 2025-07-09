import 'package:map_pro/model/language_model.dart';

class LanguageState {
  final List<LanguageModel> languages;
  final LanguageModel? selectedLanguage;
  final bool isLoading;
  final String? error;

  LanguageState({
    required this.languages,
    this.selectedLanguage,
    this.isLoading = false,
    this.error,
  });

  LanguageState copyWith({
    List<LanguageModel>? languages,
    LanguageModel? selectedLanguage,
    bool? isLoading,
    String? error,
  }) {
    return LanguageState(
      languages: languages ?? this.languages,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
