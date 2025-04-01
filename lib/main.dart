import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:stokin/core/di/init_binding.dart';

import 'core/configurations/custom_theme.dart';
import 'features/stokin/presentation/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      initialBinding: InitialBinding(),
      getPages: AppPages.routes,
      theme: CustomTheme.defaultTheme,
    ),
  );
}
