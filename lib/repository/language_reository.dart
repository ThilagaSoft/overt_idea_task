import 'package:map_pro/model/language_model.dart';

class LanguageRepository {
  List<LanguageModel> fetchLanguages() {
    return const [
      LanguageModel(name: 'English', code: 'en'),
      LanguageModel(name: 'العربية', code: 'ar'),

    ];
  }
}
