import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class Translations {
  late Map<String, dynamic> _translations;

  Future<void> loadTranslations() async { 
    String jsonString = await rootBundle.loadString(kDebugMode? 'translation.json':'assets/translation.json');
    _translations = json.decode(jsonString);
  }

  String translate(String key, String locale ) {
    if (_translations == null || !_translations.containsKey(locale)) {
      return 'Translation not found for $key and $locale';
    }
    return _translations[locale][key] ?? 'Translation not found for $key and $locale';
  }
}
