import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/app_colors.dart';
import '../../../core/app_text_styles.dart';
import '../../../routes/app_routes.dart';

class OtpPage extends StatelessWidget {
  const OtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrls = List.generate(4, (_) => TextEditingController());
    final nodes = List.generate(4, (_) => FocusNode());

    Widget otpBox(int i) {
      return SizedBox(
        width: 58,
        height: 58,

        child: TextField(
          controller: ctrls[i],
          focusNode: nodes[i],

          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,

          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),

          onChanged: (v) {
            if (v.isNotEmpty && i < 3) {
              nodes[i + 1].requestFocus();
            }

            if (v.isEmpty && i > 0) {
              nodes[i - 1].requestFocus();
            }
          },

          decoration: InputDecoration(
            counterText: '',

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
          ),
        ),
      );
    }

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

              const SizedBox(height: 12),

              // HEADER
              Center(
                child: Column(
                  children: [
                    Text(
                      'Verify OTP 🔐',
                      style: AppTextStyles.heading,
                    ),

                    const SizedBox(height: 6),

                    Text(
                      'Enter the 4-digit code sent to\n+91 98XX XXXX XX',
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
                  children: [
                    // LABEL
                    Align(
                      alignment: Alignment.centerLeft,

                      child: Text(
                        'Enter OTP',
                        style: AppTextStyles.label,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // OTP ROW
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(4, otpBox),
                    ),

                    const SizedBox(height: 20),

                    // TIMER
                    Text(
                      'Resend in 00:30',
                      style: AppTextStyles.label,
                    ),

                    const SizedBox(height: 12),

                    // ACTIONS
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {},

                          child: const Text('Resend'),
                        ),

                        const Text(' | '),

                        TextButton(
                          onPressed: () {},

                          child: const Text('Change Number'),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // BUTTON
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
                          Get.offAllNamed(AppRoutes.linkStudent);
                        },

                        child: const Text(
                          'Verify & Continue',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // SECURITY
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.verified_user_outlined,
                          size: 16,
                          color: Colors.grey,
                        ),

                        const SizedBox(width: 6),

                        Text(
                          'Secure OTP verification',
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

