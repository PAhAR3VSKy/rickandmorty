import 'dart:async';
import 'dart:convert';
import 'dart:io';

void main() async {
  final file = File('${Directory.current.path}/remove_from_coverage');
  Stream<String> lines =
      file.openRead().transform(utf8.decoder).transform(LineSplitter());
  await for (var line in lines) {
    if (line.isEmpty) continue;
    if (line.startsWith('regexp:')) {
      line = line.replaceAll('regexp:', '');
    }
    final result = await Process.run(
      'remove_from_coverage',
      [
        '-f',
        'coverage/lcov.info',
        '-r',
        line,
      ],
    );
    stdout.write(result.stdout);
    stderr.write(result.stderr);
  }
}
