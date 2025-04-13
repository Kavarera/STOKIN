import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:posapp/core/configs/custom_theme.dart';
import 'package:posapp/core/di/init_binding.dart';

import 'feature/posapp/presentation/routes/app_pages.dart';

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
