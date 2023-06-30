import 'dart:io';

void main() async {
  final rootPath = Platform.environment['MELOS_ROOT_PATH'] ?? '';
  final outDirectory = Directory('$rootPath/coverage');
  if (!outDirectory.existsSync()) {
    outDirectory.createSync(recursive: true);
    print(outDirectory.path);
  }

  final pathPrefix = Directory.current.path.replaceAll('$rootPath/', '');

  final appCoverageFilePath = '${outDirectory.path}/lcov_all.info';
  final allCoverageFile = File(appCoverageFilePath);

  final coverageFilePath = '${Directory.current.path}/coverage/lcov.info';
  final coverageFile = File(coverageFilePath);
  if (!coverageFile.existsSync()) {
    stdout.writeln('Coverage file does not exist: $coverageFilePath');
    stdout.writeln('Skip!');
    return;
  }
  if (!allCoverageFile.existsSync()) {
    allCoverageFile.createSync(recursive: true);
  }
  final lines = coverageFile.readAsLinesSync();
  for (var line in lines) {
    if (line.contains('SF:lib')) {
      line = line.replaceAll('SF:lib', 'SF:$pathPrefix/lib');
    }
    allCoverageFile.writeAsStringSync(
      '$line\n',
      mode: FileMode.append,
    );
  }
}
