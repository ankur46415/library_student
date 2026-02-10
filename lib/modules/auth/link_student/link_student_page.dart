import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/app_colors.dart';
import '../../../core/app_text_styles.dart';
import '../../../routes/app_routes.dart';

class LinkStudentPage extends StatelessWidget {
  const LinkStudentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController idCtrl = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              // BACK
              IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.arrow_back_rounded),
              ),

              const SizedBox(height: 10),

              // HEADER
              Center(
                child: Column(
                  children: [
                    Text(
                      'Link Your Account 🎓',
                      style: AppTextStyles.heading,
                    ),

                    const SizedBox(height: 6),

                    Text(
                      'Enter Student ID or scan QR code\nshared by library owner',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.body,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // CARD
              Container(
                padding: const EdgeInsets.all(22),

                decoration: BoxDecoration(
                  color: AppColors.card,

                  borderRadius: BorderRadius.circular(22),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 22,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    // LABEL
                    Text('Student ID', style: AppTextStyles.label),

                    const SizedBox(height: 8),

                    // INPUT
                    TextField(
                      controller: idCtrl,

                      textCapitalization: TextCapitalization.characters,

                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.badge_outlined),

                        hintText: 'LIB-2024-001',

                        filled: true,
                        fillColor: AppColors.background,

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(
                            color: AppColors.primary,
                            width: 1.5,
                          ),
                        ),

                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 14,
                        ),
                      ),
                    ),

                    const SizedBox(height: 6),

                    // HELPER
                    Text(
                      'Ask your library admin for correct Student ID',
                      style: AppTextStyles.label,
                    ),

                    const SizedBox(height: 18),

                    // DIVIDER
                    Row(
                      children: const [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text('OR'),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),

                    const SizedBox(height: 18),

                    // QR BUTTON
                    SizedBox(
                      width: double.infinity,

                      child: OutlinedButton.icon(
                        onPressed: () {
                          // QR later
                        },

                        icon: const Icon(Icons.qr_code_scanner_rounded),

                        label: const Text('Scan QR Code'),

                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.primary,

                          side: const BorderSide(
                            color: AppColors.primarySoft,
                          ),

                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                          ),

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 22),

                    // MAIN BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 48,

                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,

                          elevation: 3,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                        ),
                      ),

                        onPressed: () {
                          Get.offAllNamed(AppRoutes.main);
                        },

                        child: const Text(
                          'Link & Continue',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    // SECURITY NOTE
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
                          'Your data is securely linked',
                          style: AppTextStyles.label,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


