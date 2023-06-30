import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:args/args.dart';
import 'package:firebaseapis/firebaseappdistribution/v1.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:googleapis_auth/src/auth_client.dart';
import 'package:http/http.dart' as http;

import 'models/appcenter_app_release.dart';

// ignore_for_file: avoid_print

const String releaseBuildType = 'release';
String apkPath = './build/app/outputs/flutter-apk/';

String flavor = 'dev';

late String buildType;

late AutoRefreshingAuthClient authClient;

int buildNumber = 1;
late String firebaseProjectNumber;
late String firebaseAppId;

late String appSecret;
late String appName;
late String appOwner;

/// Script for build apk.
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
    ..addOption(
      'build_type',
      abbr: 't',
      defaultsTo: 'mock',
      callback: (t) => buildType = t ?? 'mock',
    )
    ..parse(arguments);

  if (Platform.environment['CI'] == 'true') {
    buildType = Platform.environment['CI_COMMIT_BRANCH'] ?? 'mock';
    if (buildType == 'cicd') buildType = 'mock';
  }

  final skipUpdateBuildNumber = Platform.environment['CI'] == 'true' &&
      (Platform.environment['CI_COMMIT_MESSAGE']?.contains('Testers updated') ??
          false);

  if (distributor == 'firebase') {
    _checkFirebaseEnvironment();

    try {
      await createFirebaseAuthClient();
      // ignore:  avoid_catches_without_on_clauses
    } catch (_) {
      exitCode = 1;
      rethrow;
    }

    try {
      await updateFirebaseBuildNumber(skipUpdate: skipUpdateBuildNumber);
      // ignore:  avoid_catches_without_on_clauses
    } catch (_) {
      exitCode = 1;
      rethrow;
    }
  } else if (distributor == 'appcenter') {
    _checkAppcenterEnvironment();

    try {
      await updateAppcenterBuildNumber(skipUpdate: skipUpdateBuildNumber);
      // ignore:  avoid_catches_without_on_clauses
    } catch (_) {
      exitCode = 1;
      rethrow;
    }
  }

  try {
    await build();
    // ignore:  avoid_catches_without_on_clauses
  } catch (_) {
    exitCode = 1;
    rethrow;
  }
}

void _checkFirebaseEnvironment() {
  if (!Platform.environment.containsKey('FIREBASE_PROJECT_NUMBER')) {
    throw Exception('You should provide FIREBASE_PROJECT_NUMBER');
  }
  firebaseProjectNumber = Platform.environment['FIREBASE_PROJECT_NUMBER'] ?? '';

  if (!Platform.environment.containsKey('FIREBASE_APP_ID_ANDROID')) {
    throw Exception('You should provide FIREBASE_APP_ID_ANDROID');
  }
  firebaseAppId = Platform.environment['FIREBASE_APP_ID_ANDROID'] ?? '';

  if (!Platform.environment.containsKey('GOOGLE_APPLICATION_CREDENTIALS')) {
    throw Exception('You should provide GOOGLE_APPLICATION_CREDENTIALS');
  }
}

void _checkAppcenterEnvironment() {
  if (!Platform.environment.containsKey('APPCENTER_APP_NAME_ANDROID')) {
    throw Exception('You should provide APPCENTER_APP_NAME_ANDROID');
  }
  appName = Platform.environment['APPCENTER_APP_NAME_ANDROID'] ?? '';

  if (!Platform.environment.containsKey('APPCENTER_APP_OWNER')) {
    throw Exception('You should provide APPCENTER_APP_OWNER');
  }
  appOwner = Platform.environment['APPCENTER_APP_OWNER'] ?? '';

  if (!Platform.environment.containsKey('APPCENTER_APP_SECRET_ANDROID')) {
    throw Exception('You should provide APPCENTER_APP_SECRET_ANDROID');
  }

  appSecret = Platform.environment['APPCENTER_APP_SECRET_ANDROID'] ?? '';
}

Future<void> createFirebaseAuthClient() async {
  final jsonPath = Platform.environment['GOOGLE_APPLICATION_CREDENTIALS'];
  final json = File(jsonPath ?? '').readAsStringSync();
  authClient = await auth.clientViaServiceAccount(
    auth.ServiceAccountCredentials.fromJson(json),
    [
      FirebaseAppDistributionApi.cloudPlatformScope,
    ],
  );
  print('Auth client created');
}

Future<void> updateFirebaseBuildNumber({bool skipUpdate = false}) async {
  final ad = FirebaseAppDistributionApi(authClient);
  final releases = await ad.projects.apps.releases.list(
    'projects/$firebaseProjectNumber/apps/$firebaseAppId',
  );
  if (releases.releases?.isNotEmpty ?? false) {
    buildNumber = int.parse(releases.releases?.first.buildVersion ?? '1');
    if (!skipUpdate) {
      buildNumber++;
      print('New build number: $buildNumber');
    } else {
      print('Build number not changed: $buildNumber');
    }
  }
}

Future<void> updateAppcenterBuildNumber({bool skipUpdate = false}) async {
  final uri = Uri.parse(
    'https://api.appcenter.ms/v0.1/apps/$appOwner/$appName/releases/',
  );
  final resp = await http.get(uri, headers: {'X-API-Token': appSecret});
  final releases = AppRelease.listFromJson(json.decode(resp.body) as List);
  if (releases.isNotEmpty) {
    final releaseNumbers = releases.map((e) => int.parse(e.version ?? '0'));
    buildNumber = releaseNumbers.reduce(max);
    if (!skipUpdate) {
      buildNumber++;
      print('New build number: $buildNumber');
    } else {
      print('Build number not changed: $buildNumber');
    }
  }
}

void resolveFlavor() {
  if (buildType == releaseBuildType) {
    flavor = 'prod';
  }
}

Future<void> build() async {
  resolveFlavor();
  await buildApk();
  await rename();
}

Future<void> buildApk() async {
  print('Build type $buildType');
  print('Flavor $flavor');

  final result = await Process.run(
    'flutter',
    [
      'build',
      'apk',
      '--build-number',
      '$buildNumber',
      '-t',
      'lib/main_$buildType.dart',
      '--flavor',
      flavor,
    ],
  );
  stdout.write(result.stdout);
  stderr.write(result.stderr);
}

Future<void> rename() async {
  await Directory('./android/build/').create(recursive: true);
  final apk = File('${apkPath}app-$flavor-release.apk');
  await apk.rename('./android/build/release.apk');
  print('APK renamed');
}
