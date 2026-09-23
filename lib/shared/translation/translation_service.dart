import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:encrypt_shared_preferences/provider.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class TranslationService extends ChangeNotifier {
  Map<String, dynamic> _translations = {};
  String _currentLanguageCode = 'en';
  final EncryptedSharedPreferences _prefs;

  TranslationService(this._prefs);

  String get currentLanguageCode => _currentLanguageCode;

  Future<void> init() async {
    final savedLang = _prefs.getString('language');
    if (savedLang != null) {
      _currentLanguageCode = savedLang;
    }
    await _loadTranslations();
  }

  Future<void> setLanguage(String languageCode) async {
    _currentLanguageCode = languageCode;
    await _prefs.setString('language', languageCode);
    await _loadTranslations();
    notifyListeners();
  }

  Future<void> _loadTranslations() async {
    try {
      final jsonString = await rootBundle.loadString(
        'assets/translation/$_currentLanguageCode.json',
      );
      _translations = json.decode(jsonString);
    } catch (e) {
      _translations = {};
    }
  }

  String translate(String key) {
    final keys = key.split('.');
    dynamic value = _translations;

    for (final k in keys) {
      if (value is Map<String, dynamic>) {
        value = value[k];
      } else {
        return key;
      }
    }

    return value?.toString() ?? key;
  }

  String t(String key) => translate(key);
}
