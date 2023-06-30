import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:http/http.dart' as http;

import 'models/new_release_file_meta.dart';
import 'models/new_release_meta.dart';

// ignore_for_file: avoid_print

late String firebaseProjectNumber;
late String firebaseAppId;

late String appSecret;
late String appName;
late String appOwner;

String buildPath = './ios/build/Runner/';

/// Script for build application.
/// Need parameter: build type -release or -qa.
/// See also usage.
///
/// Exit codes:
/// 0 - success
/// 1 - error
Future<void> main(List<String> arguments) async {
  exitCode = 0;

  var distributor = 'none';
  ArgParser()
    ..addOption(
      'distributor',
      abbr: 'd',
      defaultsTo: 'none',
      allowed: ['firebase', 'appcenter'],
      callback: (d) => distributor = d ?? 'none',
    )
    ..parse(arguments);

  if (distributor == 'firebase') {
    _checkFirebaseEnvironment();
    try {
      await firebaseDistribute();
      // ignore:  avoid_catches_without_on_clauses
    } catch (_) {
      exitCode = 1;
      rethrow;
    }
  } else if (distributor == 'appcenter') {
    _checkAppcenterEnvironment();

    try {
      await appcenterDistribute();
      // ignore:  avoid_catches_without_on_clauses
    } catch (_) {
      exitCode = 1;
      rethrow;
    }
  }
}

void _checkFirebaseEnvironment() {
  if (!Platform.environment.containsKey('FIREBASE_APP_ID_IOS')) {
    throw Exception('You should provide FIREBASE_APP_ID_IOS');
  }
  firebaseAppId = Platform.environment['FIREBASE_APP_ID_IOS'] ?? '';

  if (!Platform.environment.containsKey('GOOGLE_APPLICATION_CREDENTIALS')) {
    throw Exception('You should provide GOOGLE_APPLICATION_CREDENTIALS');
  }
}

void _checkAppcenterEnvironment() {
  if (!Platform.environment.containsKey('APPCENTER_APP_NAME_IOS')) {
    throw Exception('You should provide APPCENTER_APP_NAME_IOS');
  }
  appName = Platform.environment['APPCENTER_APP_NAME_IOS'] ?? '';

  if (!Platform.environment.containsKey('APPCENTER_APP_OWNER')) {
    throw Exception('You should provide APPCENTER_APP_OWNER');
  }
  appOwner = Platform.environment['APPCENTER_APP_OWNER'] ?? '';

  if (!Platform.environment.containsKey('APPCENTER_APP_SECRET_IOS')) {
    throw Exception('You should provide APPCENTER_APP_SECRET_IOS');
  }

  appSecret = Platform.environment['APPCENTER_APP_SECRET_IOS'] ?? '';
}

Future<void> firebaseDistribute() async {
  final args = [
    'appdistribution:distribute',
    '${buildPath}Runner.ipa',
    '--app',
    firebaseAppId,
    '--release-notes',
    ' ',
    '--testers-file',
    'testers.txt',
  ];
  final result = await Process.run(
    'firebase',
    args,
  );
  stdout.write(result.stdout);
  stderr.write(result.stderr);
}

Future<void> appcenterDistribute() async {
  var uri = Uri.parse(
    'https://api.appcenter.ms/v0.1/apps/$appOwner/$appName/uploads/releases',
  );
  var resp = await http.post(
    uri,
    headers: {
      'X-API-Token': appSecret,
      'accept': 'application/json',
      'Content-Type': 'application/json',
    },
  );

  print('New release metadata: ${resp.body}');

  final meta =
      NewReleaseMeta.fromJson(json.decode(resp.body) as Map<String, dynamic>);

  var args = [
    '-c',
    '${buildPath}Runner.ipa',
  ];
  var result = await Process.run(
    'wc',
    args,
  );

  stdout.write(result.stdout);
  if (result.exitCode != 0) {
    exitCode = result.exitCode;
    stderr.write(result.stderr);

    return;
  }
  final size = result.stdout.toString().split(' ')[1];
  print('Artifact size: $size');

  uri = Uri.parse(
    '${meta.uploadDomain}/upload/set_metadata/${meta.packageAssetId}?'
    'file_name=Runner.ipa&'
    'file_size=$size&'
    'token=${meta.urlEncodedToken}&'
    'content_type=application/octet-stream',
  );
  resp = await http.post(
    uri,
    headers: {
      'X-API-Token': appSecret,
      'accept': 'application/json',
      'Content-Type': 'application/json',
    },
  );

  print('File metadata: ${resp.body}');

  final fileMeta = NewReleaseFileMeta.fromJson(
    json.decode(resp.body) as Map<String, dynamic>,
  );

  final dir = Directory('${buildPath}split');
  await dir.create(recursive: true);

  args = [
    '-b',
    '${fileMeta.chunkSize}',
    '${buildPath}Runner.ipa',
    '${buildPath}split/split',
  ];
  result = await Process.run(
    'split',
    args,
  );
  stdout.write(result.stdout);
  if (result.exitCode != 0) {
    exitCode = result.exitCode;
    stderr.write(result.stderr);

    return;
  }

  final entities = (await dir.list().toList())
    ..sort((a, b) {
      return a.path.compareTo(b.path);
    });

  for (var i = 0; i < entities.length; i++) {
    var args = [
      '-c',
      entities[i].path,
    ];
    var result = await Process.run(
      'wc',
      args,
    );

    stdout.write(result.stdout);
    if (result.exitCode != 0) {
      exitCode = result.exitCode;
      stderr.write(result.stderr);

      return;
    }
    final size = result.stdout
        .toString()
        .split(' ')
        .firstWhere((element) => element != '');

    print('Chunk #${i + 1} size: $size');
    args = [
      '-X',
      'POST',
      '${meta.uploadDomain}/upload/upload_chunk/${meta.packageAssetId}?token=${meta.urlEncodedToken}&block_number=${i + 1}',
      '--data-binary',
      '@${entities[i].path}',
      '-H',
      'Content-Length: $size',
      '-H',
      'Content-Type: application/octet-stream',
    ];
    result = await Process.run(
      'curl',
      args,
    );

    stdout.write(result.stdout);
    if (result.exitCode != 0) {
      exitCode = result.exitCode;
      stderr.write(result.stderr);

      return;
    }
  }

  uri = Uri.parse(
    '${meta.uploadDomain}/upload/finished/${meta.packageAssetId}?'
    'token=${meta.urlEncodedToken}',
  );
  resp = await http.post(
    uri,
    headers: {
      'X-API-Token': appSecret,
      'accept': 'application/json',
      'Content-Type': 'application/json',
    },
  );

  print('Finish chunk upload response: ${resp.body}');

  uri = Uri.parse(
    'https://api.appcenter.ms/v0.1/apps/$appOwner/$appName/uploads/releases/${meta.id}',
  );
  resp = await http.patch(
    uri,
    headers: {
      'X-API-Token': appSecret,
      'accept': 'application/json',
      'Content-Type': 'application/json',
    },
    body: json.encode({
      'upload_status': 'uploadFinished',
      'id': '${meta.id}',
    }),
  );

  print('Finish upload response: ${resp.body}');

  uri = Uri.parse(
    'https://api.appcenter.ms/v0.1/apps/$appOwner/$appName/uploads/releases/${meta.id}',
  );
  resp = await http.get(
    uri,
    headers: {
      'X-API-Token': appSecret,
      'accept': 'application/json',
      'Content-Type': 'application/json',
    },
  );

  print('Await processing response: ${resp.body}');
  while (!resp.body.contains('release_distinct_id')) {
    await Future.delayed(const Duration(seconds: 1), () {});

    resp = await http.get(
      uri,
      headers: {
        'X-API-Token': appSecret,
        'accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );
    print('Await processing response: ${resp.body}');
    if (resp.body.contains('"upload_status":"error"')) {
      throw Exception(resp.body);
    }
  }
  final releaseId = (json.decode(resp.body)
      as Map<String, dynamic>)['release_distinct_id'] as int;

  print('Release id: $releaseId');

  uri = Uri.parse(
    'https://api.appcenter.ms/v0.1/apps/$appOwner/$appName/releases/$releaseId',
  );
  resp = await http.patch(
    uri,
    headers: {
      'X-API-Token': appSecret,
      'accept': 'application/json',
      'Content-Type': 'application/json',
    },
    body: json.encode({
      'destinations': [
        {'name': 'Collaborators'},
      ],
    }),
  );

  print('Finished response: ${resp.body}');
}
