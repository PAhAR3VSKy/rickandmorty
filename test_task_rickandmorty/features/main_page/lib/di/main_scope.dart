import 'package:dio/dio.dart';
import 'package:elementary/elementary.dart';
import 'package:main_page/screen/main_screen.dart';
import 'package:main_page/screen/main_screen_model.dart';

/// Интерфейс Scope для главного экрана
abstract class IMainScope {
  /// Http client.
  Dio get dio;

  /// Interface for handle error in business logic.
  ErrorHandler get errorHandler;

  /// Модель [MainScreen]
  MainScreenModel get model;
}

/// Scope
class MainScope implements IMainScope {
  final Dio _dio;
  final ErrorHandler _errorHandler;

  late final MainScreenModel _model;

  @override
  Dio get dio => _dio;

  @override
  ErrorHandler get errorHandler => _errorHandler;

  @override
  MainScreenModel get model => _model;

  /// Конструткор [MainScope]
  MainScope({
    required Dio dio,
    required ErrorHandler errorHandler,
  })  : _dio = dio,
        _errorHandler = errorHandler {
    _initTempScreenModel();
  }

  void _initTempScreenModel() {
    _model = MainScreenModel();
  }
}
