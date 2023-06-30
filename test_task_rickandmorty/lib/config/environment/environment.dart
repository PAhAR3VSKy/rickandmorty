import 'package:common/service/log_history/log_history_service_impl.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:surf_logger/surf_logger.dart' as surf;
import 'package:test_task_rickandmorty/config/environment/build_types.dart';
import 'package:test_task_rickandmorty/util/log_history.dart';

/// Environment configuration.
class Environment<T> implements Listenable {
  static Environment? _instance;
  final BuildType _currentBuildType;

  /// Configuration.
  T get config => _config.value;

  set config(T c) => _config.value = c;

  /// Is this application running in debug mode.
  bool get isDebug => _currentBuildType == BuildType.debug;

  /// Is this application running in release mode.
  bool get isRelease => _currentBuildType == BuildType.release;

  /// App build type.
  BuildType get buildType => _currentBuildType;

  ValueNotifier<T> _config;

  Environment._(this._currentBuildType, T config)
      : _config = ValueNotifier(config);

  /// Provides instance [Environment].
  factory Environment.instance() => _instance as Environment<T>;

  @override
  void addListener(VoidCallback listener) {
    _config.addListener(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    _config.removeListener(listener);
  }

  /// Initializing the environment.
  static void init<T>({
    required BuildType buildType,
    required T config,
  }) {
    _instance ??= Environment<T>._(buildType, config);
  }

  /// Add strategy to logger for save logs history for qa environment
  Future<void> createLogHistoryStrategy() async {
    if (_currentBuildType == BuildType.debug) {
      final file = await const LogHistoryServiceImpl().logHistoryFile();
      final logger = Logger(
        output: FileCustomOutput(file: file),
        printer: PrettyPrinter(lineLength: 80, noBoxingByDefault: true),
      );

      surf.Logger.addStrategy(LogHistoryStrategy(logger));
    }
  }
}
