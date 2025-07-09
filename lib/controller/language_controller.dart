import 'package:map_pro/model/language_model.dart';
import 'package:map_pro/repository/language_reository.dart';

class LanguageController {
  final LanguageRepository _repository;

  LanguageController(this._repository);

  List<LanguageModel> getLanguages() {
    return _repository.fetchLanguages();
  }
}
