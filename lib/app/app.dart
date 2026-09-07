import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_logger.dart';
import 'config.dart';
import 'error/app_error.dart';
import 'router.dart';
import 'theme.dart';

class FinanceTrackerApp extends ConsumerWidget {
  const FinanceTrackerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(appConfigProvider);

    return MaterialApp.router(
      title: config.appName,
      theme: buildAppTheme(),
      routerConfig: appRouter,
      builder: (context, child) {
        return child ?? const SizedBox.shrink();
      },
    );
  }
}

void configureErrorHandling() {
  FlutterError.onError = (details) {
    AppLogger.error('Flutter framework error', details.exception);
  };

  ErrorWidget.builder = (details) {
    AppLogger.error('Widget rendering failed', details.exception);
    return const AppErrorView();
  };

  PlatformDispatcher.instance.onError = (error, stackTrace) {
    AppLogger.error('Unhandled platform error', error, stackTrace);
    return true;
  };
}

void runFinanceTracker() {
  configureErrorHandling();
  runZonedGuarded(
    () => runApp(const ProviderScope(child: FinanceTrackerApp())),
    (error, stackTrace) =>
        AppLogger.error('Unhandled application error', error, stackTrace),
  );
}
