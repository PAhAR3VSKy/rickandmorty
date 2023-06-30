import 'dart:ui';

import 'package:character_card/character_card_model.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:elementary/elementary.dart';
import 'package:navigation/service/router.dart';
import 'package:test_task_rickandmorty/config/app_config.dart';
import 'package:test_task_rickandmorty/config/environment/environment.dart';
import 'package:test_task_rickandmorty/tracked/tracked_notifaer.dart';
import 'package:test_task_rickandmorty/util/default_error_handler.dart';

/// Scope of dependencies which need through all app's life.
class AppScope implements IAppScope {
  late final Dio _dio;
  late final ErrorHandler _errorHandler;
  late final AppRouter _router;
  late final CharacterCardModel _characterCardModel;
  late final ITrackedNotifier _trackedNotifier;

  late VoidCallback _applicationRebuilder;

  @override
  Dio get dio => _dio;

  @override
  AppRouter get router => _router;

  @override
  ErrorHandler get errorHandler => _errorHandler;

  @override
  VoidCallback get applicationRebuilder => _applicationRebuilder;

  @override
  CharacterCardModel get characterCardModel => _characterCardModel;

  @override
  ITrackedNotifier get trackedNotifier => _trackedNotifier;

  /// Установка функции ребилда приложения
  set applicationRebuilder(Function() rebuild) =>
      _applicationRebuilder = rebuild;

  /// Create an instance [AppScope].
  AppScope() {
    /// List interceptor. Fill in as needed.
    final additionalInterceptors = <Interceptor>[];

    _dio = _initDio(additionalInterceptors);
    _errorHandler = DefaultErrorHandler();
    _router = AppRouter.instance();
    _initTrackedNotifier();
    _initCharacterCardModel();
  }

  Dio _initDio(Iterable<Interceptor> additionalInterceptors) {
    const timeout = Duration(seconds: 30);

    final dio = Dio();

    dio.options
      ..baseUrl = Environment<AppConfig>.instance().config.url
      ..connectTimeout = timeout.inMilliseconds
      ..receiveTimeout = timeout.inMilliseconds
      ..sendTimeout = timeout.inMilliseconds;

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      final proxyUrl = Environment<AppConfig>.instance().config.proxyUrl;
      if (proxyUrl != null && proxyUrl.isNotEmpty) {
        client
          ..findProxy = (uri) {
            return 'PROXY $proxyUrl';
          }
          ..badCertificateCallback = (_, __, ___) {
            return true;
          };
      }
      return null;
    };

    dio.interceptors.addAll(additionalInterceptors);

    if (Environment<AppConfig>.instance().isDebug) {
      dio.interceptors
          .add(LogInterceptor(requestBody: true, responseBody: true));
    }

    return dio;
  }

  /// Инициализация scope
  Future<void> init() async {}

  Future<void> _initTrackedNotifier() async {
    _trackedNotifier = TrackedNotifier();

    await _trackedNotifier.load();
  }

  void _initCharacterCardModel() {
    _characterCardModel = CharacterCardModel(
      _trackedNotifier,
      errorHandler,
    );
  }
}

/// App dependencies.
abstract class IAppScope {
  /// Http client.
  Dio get dio;

  /// Interface for handle error in business logic.
  ErrorHandler get errorHandler;

  /// Callback to rebuild the whole application.
  VoidCallback get applicationRebuilder;

  /// Class that coordinates navigation for the whole app.
  AppRouter get router;

  /// Модуль отслеживаемых
  ITrackedNotifier get trackedNotifier;

  /// Card character
  CharacterCardModel get characterCardModel;
}
