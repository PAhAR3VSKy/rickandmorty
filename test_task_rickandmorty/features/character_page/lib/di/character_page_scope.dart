import 'package:character_page/api/client.dart';
import 'package:character_page/character_page_model.dart';
import 'package:character_page/repository/character_repository.dart';
import 'package:dio/dio.dart';
import 'package:elementary/elementary.dart';

/// Интерфейс scope для экрана персонажей
abstract class ICharacterPageScope {
  /// Http client
  Dio get dio;

  /// Интерфейс handler error бизнес логики
  ErrorHandler get errorHandler;

  /// модель страницы
  CharacterPageModel get model;
}

/// Scope для страницы
class CharacterPageScope implements ICharacterPageScope {
  final Dio _dio;
  final ErrorHandler _errorHandler;
  late final CharacterPageModel _model;
  late final CharacterClient _client;

  @override
  Dio get dio => _dio;

  @override
  ErrorHandler get errorHandler => _errorHandler;

  @override
  CharacterPageModel get model => _model;

  /// Конструктор scope страницы персонажей
  CharacterPageScope({
    required Dio dio,
    required ErrorHandler errorHandler,
  })  : _dio = dio,
        _errorHandler = errorHandler,
        _client = CharacterClient(dio) {
    _initModel();
  }

  void _initModel() {
    _model = CharacterPageModel(CharacterRepository(_client), errorHandler);
  }
}
