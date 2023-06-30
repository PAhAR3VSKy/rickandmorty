import 'package:dio/dio.dart';
import 'package:elementary/elementary.dart';
import 'package:favorite/api/client.dart';
import 'package:favorite/favorite_model.dart';
import 'package:favorite/repository/favorite_repository.dart';
import 'package:test_task_rickandmorty/tracked/tracked_notifaer.dart';

/// Интерфейс Scope страницы избранного
abstract class IFavoritePageScope {
  /// Http
  Dio get dio;

  /// Error handler
  ErrorHandler get errorHandler;

  /// Модель страницы избранного
  FavoritePageModel get model;
}

/// Scope страницы избранного
class FavoritePageScope implements IFavoritePageScope {
  final Dio _dio;
  final ErrorHandler _errorHandler;
  late final FavoritePageModel _model;
  late final FavoriteClient _client;
  late final ITrackedNotifier _trackedNotifier;

  @override
  Dio get dio => _dio;

  @override
  ErrorHandler get errorHandler => _errorHandler;

  @override
  FavoritePageModel get model => _model;

  /// Конструктор [FavoritePageScope]
  FavoritePageScope({
    required Dio dio,
    required ErrorHandler errorHandler,
    required ITrackedNotifier trackedNotifier,
  })  : _dio = dio,
        _errorHandler = errorHandler,
        _trackedNotifier = trackedNotifier,
        _client = FavoriteClient(dio) {
    _initModel();
  }

  void _initModel() {
    _model = FavoritePageModel(
      _trackedNotifier,
      FavoriteRepository(_client),
      errorHandler,
    );
  }
}
