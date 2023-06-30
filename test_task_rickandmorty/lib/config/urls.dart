import 'package:test_task_rickandmorty/config/app_config.dart';
import 'package:test_task_rickandmorty/config/environment/environment.dart';

/// Server urls.
abstract class Url {
  /// Prod proxy url.
  static String get prodProxyUrl => '';

  /// QA proxy url.
  static String get qaProxyUrl => '192.168.0.1';

  /// Dev proxy url.
  static String get devProxyUrl => '';

  /// TRest url.
  static String get testUrl => 'https://rickandmortyapi.com/api';

  /// Prod url.
  static String get prodUrl => 'https://rickandmortyapi.com/api';

  /// Dev url.
  static String get devUrl => 'https://localhost:9999/food/hs/ExchangeSotr';

  /// Base url.
  static String get baseUrl => Environment<AppConfig>.instance().config.url;
}

/// Ury type.
enum UrlType {
  /// Test.
  test('https://rickandmortyapi.com/api', ''),

  /// Prod.
  prod('https://rickandmortyapi.com/api', ''),

  /// Dev.
  dev('https://localhost:9999/food/hs/ExchangeSotr', '');

  /// Основная ссылка
  final String url;

  /// Ссылка на прокси
  final String? proxyUrl;

  /// Enum для выбора сервера
  const UrlType(this.url, this.proxyUrl);
}
