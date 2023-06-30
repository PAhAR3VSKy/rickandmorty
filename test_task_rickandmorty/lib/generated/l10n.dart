// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class AppLocalizations {
  AppLocalizations();

  static AppLocalizations? _current;

  static AppLocalizations get current {
    assert(_current != null,
        'No instance of AppLocalizations was loaded. Try to initialize the AppLocalizations delegate before accessing AppLocalizations.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<AppLocalizations> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = AppLocalizations();
      AppLocalizations._current = instance;

      return instance;
    });
  }

  static AppLocalizations of(BuildContext context) {
    final instance = AppLocalizations.maybeOf(context);
    assert(instance != null,
        'No instance of AppLocalizations present in the widget tree. Did you add AppLocalizations.delegate in localizationsDelegates?');
    return instance!;
  }

  static AppLocalizations? maybeOf(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  /// `Рик и Морти`
  String get rickAndMorty {
    return Intl.message(
      'Рик и Морти',
      name: 'rickAndMorty',
      desc: '',
      args: [],
    );
  }

  /// `Выбрать статус`
  String get choiceStatus {
    return Intl.message(
      'Выбрать статус',
      name: 'choiceStatus',
      desc: '',
      args: [],
    );
  }

  /// `Статус`
  String get status {
    return Intl.message(
      'Статус',
      name: 'status',
      desc: '',
      args: [],
    );
  }

  /// `Выбрать гендер`
  String get choiceGender {
    return Intl.message(
      'Выбрать гендер',
      name: 'choiceGender',
      desc: '',
      args: [],
    );
  }

  /// `Гендер`
  String get gender {
    return Intl.message(
      'Гендер',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `Введите имя персонажа`
  String get writeName {
    return Intl.message(
      'Введите имя персонажа',
      name: 'writeName',
      desc: '',
      args: [],
    );
  }

  /// `Произошла ошибка запроса,\nповторите запрос`
  String get occurredError {
    return Intl.message(
      'Произошла ошибка запроса,\nповторите запрос',
      name: 'occurredError',
      desc: '',
      args: [],
    );
  }

  /// `Перезагрузить`
  String get reload {
    return Intl.message(
      'Перезагрузить',
      name: 'reload',
      desc: '',
      args: [],
    );
  }

  /// `Введите расу`
  String get writeSpecies {
    return Intl.message(
      'Введите расу',
      name: 'writeSpecies',
      desc: '',
      args: [],
    );
  }

  /// `Имя`
  String get name {
    return Intl.message(
      'Имя',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Раса`
  String get species {
    return Intl.message(
      'Раса',
      name: 'species',
      desc: '',
      args: [],
    );
  }

  /// `Вид`
  String get type {
    return Intl.message(
      'Вид',
      name: 'type',
      desc: '',
      args: [],
    );
  }

  /// `Место рождения`
  String get origin {
    return Intl.message(
      'Место рождения',
      name: 'origin',
      desc: '',
      args: [],
    );
  }

  /// `Место нахождения`
  String get location {
    return Intl.message(
      'Место нахождения',
      name: 'location',
      desc: '',
      args: [],
    );
  }

  /// `Дата рождения`
  String get created {
    return Intl.message(
      'Дата рождения',
      name: 'created',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
