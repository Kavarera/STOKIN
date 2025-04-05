import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stokin_bloc/features/stokin/presentation/bloc/home/home_bloc.dart';
import 'package:stokin_bloc/stokin_observer.dart';

import 'cores/configurations/custom_theme.dart';
import 'cores/di/dependency_injection.dart';
import 'cores/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init(); // Uncomment this if you have DI setup
  Bloc.observer = StokinObserver();
  runApp(
    MaterialApp.router(
      routerConfig: AppRoutes().router,
      theme: CustomTheme.defaultTheme,
    ),
  );
}
