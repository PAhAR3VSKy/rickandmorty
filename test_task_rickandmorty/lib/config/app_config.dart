import 'package:test_task_rickandmorty/config/debug_options.dart';
import 'package:test_task_rickandmorty/config/urls.dart';

/// Application configuration.
class AppConfig {
  /// [UrlType]
  final UrlType urlType;

  /// Server url.
  String get url => urlType.url;

  /// Proxy url.
  String? get proxyUrl => urlType.proxyUrl;

  /// Additional application settings in debug mode.
  final DebugOptions debugOptions;

  /// Use mock data
  final bool useMock;

  /// Create an instance [AppConfig].
  AppConfig({
    required this.urlType,
    required this.debugOptions,
    this.useMock = false,
  });

  /// Create an instance [AppConfig] with modified parameters.
  AppConfig copyWith({
    UrlType? urlType,
    bool? useMock,
    DebugOptions? debugOptions,
  }) =>
      AppConfig(
        urlType: urlType ?? this.urlType,
        debugOptions: debugOptions ?? this.debugOptions,
        useMock: useMock ?? this.useMock,
      );
}
