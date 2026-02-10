import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/app_colors.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';

void main() {
  runApp(const LibraryStudentApp());
}

class LibraryStudentApp extends StatelessWidget {
  const LibraryStudentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Library Student',
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          background: AppColors.background,
        ),
        textTheme: GoogleFonts.interTextTheme(),
        useMaterial3: true,
      ),
    );
  }
}
