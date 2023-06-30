import 'package:surf_logger/surf_logger.dart';

/// Класс обработчик exception сущностей для презентативной логики
class ExceptionHandler {
  /// Оболочка с обработчиком ошибок для функции
  static Future<void> shellException(Future Function() function) async {
    try {
      await function();
    }
    // ignore: avoid_catches_without_on_clauses
    catch (e, trace) {
      final msg = _msgError(e);
      if (e is Exception) {
        Logger.e(
          msg,
          Exception('exception: ${e.toString()} \n trace: $trace'),
        );
      } else if (e is Error) {
        Logger.e(
          msg,
          Exception(trace),
        );
      }
      throw FormatException(msg);
    }
  }
}

String _msgError(Object error) {
    return 'error';
}
