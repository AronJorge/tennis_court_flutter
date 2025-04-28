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

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Iniciar sesión`
  String get loginTitle {
    return Intl.message(
      'Iniciar sesión',
      name: 'loginTitle',
      desc: '',
      args: [],
    );
  }

  /// `Correo electrónico`
  String get emailLabel {
    return Intl.message(
      'Correo electrónico',
      name: 'emailLabel',
      desc: '',
      args: [],
    );
  }

  /// `Contraseña`
  String get passwordLabel {
    return Intl.message(
      'Contraseña',
      name: 'passwordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Recordar contraseña`
  String get rememberPassword {
    return Intl.message(
      'Recordar contraseña',
      name: 'rememberPassword',
      desc: '',
      args: [],
    );
  }

  /// `¿Olvidaste tu contraseña?`
  String get forgotPassword {
    return Intl.message(
      '¿Olvidaste tu contraseña?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Iniciar sesión`
  String get loginButton {
    return Intl.message(
      'Iniciar sesión',
      name: 'loginButton',
      desc: '',
      args: [],
    );
  }

  /// `¿Aún no tienes cuenta?`
  String get noAccount {
    return Intl.message(
      '¿Aún no tienes cuenta?',
      name: 'noAccount',
      desc: '',
      args: [],
    );
  }

  /// `Regístrate`
  String get registerButton {
    return Intl.message(
      'Regístrate',
      name: 'registerButton',
      desc: '',
      args: [],
    );
  }

  /// `Credenciales inválidas`
  String get invalidCredentials {
    return Intl.message(
      'Credenciales inválidas',
      name: 'invalidCredentials',
      desc: '',
      args: [],
    );
  }

  /// `Usuario no encontrado`
  String get userNotFound {
    return Intl.message(
      'Usuario no encontrado',
      name: 'userNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Error al cargar las canchas`
  String get failedToLoadCourts {
    return Intl.message(
      'Error al cargar las canchas',
      name: 'failedToLoadCourts',
      desc: '',
      args: [],
    );
  }

  /// `Error al cargar las reservas`
  String get failedToLoadReservations {
    return Intl.message(
      'Error al cargar las reservas',
      name: 'failedToLoadReservations',
      desc: '',
      args: [],
    );
  }

  /// `Por favor completa todos los campos.`
  String get emptyFields {
    return Intl.message(
      'Por favor completa todos los campos.',
      name: 'emptyFields',
      desc: '',
      args: [],
    );
  }

  /// `Por favor ingresa un email válido.`
  String get invalidEmail {
    return Intl.message(
      'Por favor ingresa un email válido.',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Las contraseñas no coinciden.`
  String get passwordsDoNotMatch {
    return Intl.message(
      'Las contraseñas no coinciden.',
      name: 'passwordsDoNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Error al iniciar sesión.`
  String get errorLogin {
    return Intl.message(
      'Error al iniciar sesión.',
      name: 'errorLogin',
      desc: '',
      args: [],
    );
  }

  /// `Error al registrar la cuenta.`
  String get errorRegister {
    return Intl.message(
      'Error al registrar la cuenta.',
      name: 'errorRegister',
      desc: '',
      args: [],
    );
  }

  /// `Error desconocido.`
  String get unknownError {
    return Intl.message(
      'Error desconocido.',
      name: 'unknownError',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
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
