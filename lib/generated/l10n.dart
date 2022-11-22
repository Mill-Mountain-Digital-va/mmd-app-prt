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
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
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
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Break`
  String get break_str {
    return Intl.message(
      'Break',
      name: 'break_str',
      desc: '',
      args: [],
    );
  }

  /// `Turn Break`
  String get turn_break_str {
    return Intl.message(
      'Turn Break',
      name: 'turn_break_str',
      desc: '',
      args: [],
    );
  }

  /// `Exercise`
  String get exercise {
    return Intl.message(
      'Exercise',
      name: 'exercise',
      desc: '',
      args: [],
    );
  }

  /// `Turn`
  String get turn {
    return Intl.message(
      'Turn',
      name: 'turn',
      desc: '',
      args: [],
    );
  }

  /// `Next Turn`
  String get next_turn {
    return Intl.message(
      'Next Turn',
      name: 'next_turn',
      desc: '',
      args: [],
    );
  }

  /// `Finish Workout`
  String get finish_workout {
    return Intl.message(
      'Finish Workout',
      name: 'finish_workout',
      desc: '',
      args: [],
    );
  }

  /// `Wrong Email or Password`
  String get wrong_email_or_password {
    return Intl.message(
      'Wrong Email or Password',
      name: 'wrong_email_or_password',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get welcome {
    return Intl.message(
      'Welcome',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `You must signin to access to this section`
  String get you_must_signin_to_access_to_this_section {
    return Intl.message(
      'You must signin to access to this section',
      name: 'you_must_signin_to_access_to_this_section',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Sign UP`
  String get signup {
    return Intl.message(
      'Sign UP',
      name: 'signup',
      desc: '',
      args: [],
    );
  }

  /// `I dont have an account`
  String get i_dont_have_an_account {
    return Intl.message(
      'I dont have an account',
      name: 'i_dont_have_an_account',
      desc: '',
      args: [],
    );
  }

  /// `Exercise Help`
  String get exercise_help {
    return Intl.message(
      'Exercise Help',
      name: 'exercise_help',
      desc: '',
      args: [],
    );
  }

  /// `Get Ready`
  String get get_ready {
    return Intl.message(
      'Get Ready',
      name: 'get_ready',
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
      Locale.fromSubtags(languageCode: 'pt'),
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
