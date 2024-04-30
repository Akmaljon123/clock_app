enum Languages{
  en, ru, uz
}

class LanguageService{
  static Languages _languages = Languages.en;
  static Languages get getLanguage => _languages;

  static set setLanguage(Languages languages){
    _languages = languages;
  }

  static void switchLanguage(String language){
    switch(language){
      case "en":
        LanguageService.setLanguage = Languages.en;
        break;
      case "ru":
        LanguageService.setLanguage = Languages.ru;
        break;
      case "uz":
        LanguageService.setLanguage = Languages.uz;
        break;
      default:
        LanguageService.setLanguage = Languages.en;
    }
  }
}