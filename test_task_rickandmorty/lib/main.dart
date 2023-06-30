import 'package:test_task_rickandmorty/config/app_config.dart';
import 'package:test_task_rickandmorty/config/debug_options.dart';
import 'package:test_task_rickandmorty/config/environment/build_types.dart';
import 'package:test_task_rickandmorty/config/environment/environment.dart';
import 'package:test_task_rickandmorty/config/urls.dart';
import 'package:test_task_rickandmorty/runner.dart';

/// Main entry point of app.
void main() {
  Environment.init(
    buildType: BuildType.debug,
    config: AppConfig(
      urlType: UrlType.test,
      debugOptions: DebugOptions(
        debugShowCheckedModeBanner: true,
      ),
    ),
  );

  run();
}
