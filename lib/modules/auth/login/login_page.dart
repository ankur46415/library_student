import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/app_colors.dart';
import '../../../core/app_text_styles.dart';
import '../auth_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController phoneCtrl = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // 🔷 APP LOGO / ICON
              Center(
                child: Container(
                  height: 72,
                  width: 72,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.school_rounded,
                    color: AppColors.primary,
                    size: 34,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // 👋 HEADER
              Center(
                child: Column(
                  children: [
                    Text(
                      'Welcome 👋',
                      style: AppTextStyles.heading,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Login to manage your library easily',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.body,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              // 🧾 LOGIN CARD
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Sign in to continue',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: Obx(() {
                          final authController = Get.find<AuthController>();
                          return ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black87,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                                side: BorderSide(color: Colors.grey.shade300),
                              ),
                            ),
                            icon: authController.isLoading.value
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(strokeWidth: 2),
                                  )
                                : Image.asset(
                                    'assets/images/google_logo.png', // Assuming asset exists, otherwise use Icon
                                    height: 24,
                                    errorBuilder: (context, error, stackTrace) =>
                                        const Icon(Icons.login, color: Colors.blue),
                                  ),
                            onPressed: authController.isLoading.value
                                ? null
                                : () {
                                    authController.signInWithGoogle();
                                  },
                            label: Text(
                              authController.isLoading.value
                                  ? 'Signing in...'
                                  : 'Sign in with Google',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 30),
              // 📜 FOOTER
              Center(
                child: Text(
                  'By continuing, you agree to our Terms & Rules',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.label,
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}


