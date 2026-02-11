import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';
import '../../routes/app_routes.dart';
import '../../services/firebase_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseService _firebaseService = FirebaseService();

  @override
  void initState() {
    super.initState();
    _handleNavigation();
  }

  Future<void> _handleNavigation() async {
    // Small splash delay
    await Future.delayed(const Duration(milliseconds: 1400));

    final user = _auth.currentUser;

    // Not logged in → go to login
    if (!mounted) return;
    if (user == null) {
      Get.offAllNamed(AppRoutes.login);
      return;
    }

    // Logged in → check if linkedUserId exists
    final linkedUserId = await _firebaseService.getLinkedUserId();
    if (!mounted) return;

    if (linkedUserId != null && linkedUserId.isNotEmpty) {
      // Already linked → Home
      Get.offAllNamed(AppRoutes.main);
    } else {
      // Not linked → Link student flow
      Get.offAllNamed(AppRoutes.linkStudent);
    }
  }

  @override
  Widget build(BuildContext context) {
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


