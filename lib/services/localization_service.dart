import 'dart:ui';
import 'package:get/get.dart';

import '../lang/en_us.dart';
import '../lang/tr_tr.dart';
//import '../lang/tr_tr.dart' as TR ;

class LocalizationService extends Translations {
   static late var locale = Locale("en", "US");

  static final fallbackLocale = Locale('tr', 'TR');


  static final langs = ["English", "Türkçe"];

  static final locales = [
    Locale("en", "US"),
    Locale("tr", "TR"),
  ];

  @override
  Map<String, Map<String, String>> get keys => {
        "en_US": enEN,
        "tr_TR": trTR,
        // "tr_TR":TR.trTR,
      };

  void changeLocale(String lang) {
    final locale = _getLocaleFromLanguage(lang);
    Get.updateLocale(locale);
  }

  // Finds language in `langs` list and returns it as Locale
  Locale _getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }
    return Get.locale!;
  }
}
