import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';
import '../../routes/app_routes.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 1400), () {
      Get.offAllNamed(AppRoutes.login);
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.card,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const Icon(
                Icons.local_library_rounded,
                size: 42,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Your Study Library',
              style: AppTextStyles.heading,
            ),
            const SizedBox(height: 8),
            Text(
              'Premium student access',
              style: AppTextStyles.body,
            ),
          ],
        ),
      ),
    );
  }
}


