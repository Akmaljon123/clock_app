import '../data/en.dart';
import '../data/ru.dart';
import '../data/uz.dart';
import 'language_service.dart';

extension LanguageExtension on String{
  String get translate{
    switch(LanguageService.getLanguage){
      case Languages.en:
        return en[this] ?? this;
      case Languages.ru:
        return ru[this] ?? this;
      case Languages.uz:
        return uz[this] ?? this;
    }
  }
}