import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/app_colors.dart';
import '../../../core/app_text_styles.dart';
import '../../../routes/app_routes.dart';

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // LABEL
                    Text(
                      'Mobile Number',
                      style: AppTextStyles.label,
                    ),
                    const SizedBox(height: 10),
                    // INPUT
                    TextField(
                      controller: phoneCtrl,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.phone_android),
                        prefixText: '+91 ',
                        filled: true,
                        fillColor: AppColors.background,
                        hintText: '9876 543 210',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 14,
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),
                    // BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: () {
                          Get.toNamed(AppRoutes.otp);
                        },
                        child: const Text(
                          'Continue',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // DIVIDER
                    Row(
                      children: [
                        Expanded(child: Divider(color: Colors.grey.shade300)),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            'Secure Login',
                            style: TextStyle(fontSize: 11),
                          ),
                        ),
                        Expanded(child: Divider(color: Colors.grey.shade300)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // SECURITY
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.lock_outline,
                          size: 16,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Your data is protected',
                          style: AppTextStyles.label,
                        ),
                      ],
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


