import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posapp_bloc/core/configs/custom_theme.dart';
import 'package:posapp_bloc/posapp_observer.dart';

import 'core/di/dependency_injection.dart';
import 'features/posapp_bloc/presentation/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init(); // Uncomment this if you have DI setup
  Bloc.observer = PosAppObserver();
  runApp(
    MaterialApp.router(
      routerConfig: AppRoutes().router,
      theme: CustomTheme.defaultTheme,
    ),
  );
}
