import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:joinder_app/app/app_module.dart';

import 'package:sentry/sentry.dart';

var sentry = SentryClient(dsn: "https://accf8b980fb840f6ab96a1f86bb2a169@o378961.ingest.sentry.io/5379090");

main() async {
  try {
    runApp(ModularApp(module: AppModule()));
  } catch (error, stackTrace) {
    await sentry.captureException(
      exception: error,
      stackTrace: stackTrace,
    );
  }
}
