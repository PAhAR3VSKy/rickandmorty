import 'dart:async';
import 'dart:io';

import 'package:common/service/log_history/log_history_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

final _lTime = ValueNotifier<String>('');

/// A service that work with log history.
class LogHistoryServiceImpl implements LogHistoryService {
  static const _fileName = 'debug-log.txt';

  /// Create an instance [LogHistoryServiceImpl].
  const LogHistoryServiceImpl();

  @override
  Future<void> clearLogHistory() async {
    final file = await logHistoryFile();
    _lTime.value = '${DateTime.now()}';
    await file.writeAsString('');
  }

  @override
  Future<String> loadFile() async {
    final file = await logHistoryFile();

    final contents = await file.readAsString();

    return contents.replaceAll('\u0000', '');
  }

  @override
  Future<File> logHistoryFile() async {
    final directory = await getApplicationDocumentsDirectory();
    final fullPath = join(directory.path, _fileName);
    return File(fullPath);
  }

  /// Подписка на изменение логера
  void sub(Function() func) => _lTime.addListener(func);

  /// Отписка на изменение логера
  void unSub(Function() func) => _lTime.removeListener(func);
}
