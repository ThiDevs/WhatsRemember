import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['pt', 'en'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? ptText = '',
    String? enText = '',
  }) =>
      [ptText, enText][languageIndex] ?? '';
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    final language = locale.toString();
    return FFLocalizations.languages().contains(
      language.endsWith('_')
          ? language.substring(0, language.length - 1)
          : language,
    );
  }

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // Login
  {
    '4pgx61sd': {
      'pt': 'Sign in with Google',
      'en': 'Sign in with Google',
    },
    'wan8ie11': {
      'pt': 'WhatsRemember',
      'en': 'WhatsRemember',
    },
    'vr4kkbak': {
      'pt': 'Home',
      'en': 'Home',
    },
  },
  // HomePage
  {
    'rur9mv1p': {
      'pt': '09:15 recorrente todos os dias',
      'en': '09:15 recurring every day',
    },
    '6mx7ta2p': {
      'pt': 'WhatsRemember',
      'en': 'WhatsRemember',
    },
    'islk4yh7': {
      'pt': 'Home',
      'en': 'Home',
    },
  },
  // AddAlarm
  {
    'h8evsuap': {
      'pt': 'Phone number',
      'en': 'phone number',
    },
    'wnnodhqn': {
      'pt': 'Verificar Numero',
      'en': '',
    },
    'n242zr9o': {
      'pt': 'Message send',
      'en': 'message send',
    },
    'dlkgj9at': {
      'pt': 'Segunda',
      'en': 'Second',
    },
    'biod0jr6': {
      'pt': 'Terça',
      'en': 'Tuesday',
    },
    'kvkidw1b': {
      'pt': 'Quarta',
      'en': 'Fourth',
    },
    'g69ejeei': {
      'pt': 'Quinta',
      'en': 'Fifth',
    },
    '0qmh9qz2': {
      'pt': 'Sexta',
      'en': 'friday',
    },
    'cy5st06r': {
      'pt': 'Sábado',
      'en': 'Saturday',
    },
    'ibbrod2u': {
      'pt': 'Domingo',
      'en': 'Sunday',
    },
    '66rd6yzs': {
      'pt': 'Salvar',
      'en': 'To save',
    },
    '78lmpjjy': {
      'pt': 'Adicionar novo alarme',
      'en': 'add new alarm',
    },
    'g9dcme2z': {
      'pt': 'Home',
      'en': 'Home',
    },
  },
  // Miscellaneous
  {
    'siu6x4js': {
      'pt': '',
      'en': '',
    },
    'a59ejjmv': {
      'pt': '',
      'en': '',
    },
    'hdqonkzh': {
      'pt': '',
      'en': '',
    },
    'eci8jf0w': {
      'pt': '',
      'en': '',
    },
    'cj1uuqpq': {
      'pt': '',
      'en': '',
    },
    'rrrfv4c7': {
      'pt': '',
      'en': '',
    },
    'zpvgav7r': {
      'pt': '',
      'en': '',
    },
    'wfjt7dxd': {
      'pt': '',
      'en': '',
    },
    'h47i2glf': {
      'pt': '',
      'en': '',
    },
    'frp2v0ku': {
      'pt': '',
      'en': '',
    },
    'hj1ug9uj': {
      'pt': '',
      'en': '',
    },
    'grq2tlgg': {
      'pt': '',
      'en': '',
    },
    '9fud4tgp': {
      'pt': '',
      'en': '',
    },
    'b31g4wvl': {
      'pt': '',
      'en': '',
    },
    'mjd47bic': {
      'pt': '',
      'en': '',
    },
    'dr82m2ub': {
      'pt': '',
      'en': '',
    },
    'vtpw8b3t': {
      'pt': '',
      'en': '',
    },
    'yqvbwgou': {
      'pt': '',
      'en': '',
    },
    'ab9c3mjb': {
      'pt': '',
      'en': '',
    },
    'gce4n0w9': {
      'pt': '',
      'en': '',
    },
  },
].reduce((a, b) => a..addAll(b));
