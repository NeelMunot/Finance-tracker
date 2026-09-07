import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppConfig {
  const AppConfig({required this.appName, required this.environment});

  factory AppConfig.fromEnvironment() {
    return const AppConfig(
      appName: String.fromEnvironment(
        'APP_NAME',
        defaultValue: 'Finance Tracker',
      ),
      environment: String.fromEnvironment(
        'APP_ENV',
        defaultValue: 'development',
      ),
    );
  }

  final String appName;
  final String environment;
}

final appConfigProvider = Provider<AppConfig>((ref) {
  return AppConfig.fromEnvironment();
});
