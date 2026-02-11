import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';
import '../auth/auth_controller.dart';
import 'profile_controller.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Profile', style: AppTextStyles.subheading),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Text(
              controller.errorMessage.value,
              style: AppTextStyles.body,
              textAlign: TextAlign.center,
            ),
          );
        }

        final user = controller.userData.value ?? {};
        final student = controller.studentData.value ?? {};

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _header(user: user, student: student),
              const SizedBox(height: 14),
              _infoCard(user: user, student: student),
              const SizedBox(height: 14),
              _settingsCard(),
            ],
          ),
        );
      }),
    );
  }

  Widget _header({
    required Map<String, dynamic> user,
    required Map<String, dynamic> student,
  }) {
    final name = student['name'] ?? student['fullName'] ?? user['name'] ?? 'Student';
    final seat = student['seat'] ?? student['seatNumber'];
    final libraryName = student['libraryName'] ?? user['libraryName'] ?? user['libraryId'];

    String subtitle = '';
    if (seat != null && libraryName != null) {
      subtitle = 'Seat $seat \u2022 $libraryName';
    } else if (libraryName != null) {
      subtitle = '$libraryName';
    }

    return Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: AppColors.primarySoft,
              child: const Icon(Icons.person_rounded, size: 40, color: AppColors.primary),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.edit_rounded, size: 14, color: Colors.white),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: AppTextStyles.subheading.copyWith(fontSize: 18),
        ),
        if (subtitle.isNotEmpty) ...[
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: AppTextStyles.body.copyWith(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ],
    );
  }

  Widget _infoCard({
    required Map<String, dynamic> user,
    required Map<String, dynamic> student,
  }) {
    final email = user['email'] ?? '-';
    final linkedUserId = user['linkedUserId'] ?? '-';
    final phone = student['mobile'] ?? student['phone'] ?? student['contact'] ?? '-';
    final libraryName = student['libraryName'] ?? user['libraryName'] ?? user['libraryId'] ?? '-';
    final plan = student['plan'] ?? student['planType'] ?? 'N/A';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          _infoRow('Email', email.toString()),
          const Divider(height: 20),
          _infoRow('Student ID', linkedUserId.toString()),
          const Divider(height: 20),
          _infoRow('Mobile number', phone.toString()),
          const Divider(height: 20),
          _infoRow('Library name', libraryName.toString()),
          const Divider(height: 20),
          _infoRow('Plan type', plan.toString()),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.label.copyWith(
            fontSize: 13,
            color: AppColors.textSecondary,
          ),
        ),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: AppTextStyles.subheading.copyWith(fontSize: 14),
          ),
        ),
      ],
    );
  }

  Widget _settingsCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          _settingsTile(icon: Icons.rule_rounded, label: 'Rules & guidelines'),
          _settingsTile(icon: Icons.notifications_active_rounded, label: 'Notification settings'),
          _settingsTile(icon: Icons.support_agent_rounded, label: 'Help & support'),
          const SizedBox(height: 6),
          TextButton.icon(
            onPressed: () {
              final authController = Get.find<AuthController>();
              authController.signOut();
            },
            icon: const Icon(Icons.logout_rounded, color: AppColors.danger),
            label: const Text(
              'Logout',
              style: TextStyle(
                color: AppColors.danger,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _settingsTile({required IconData icon, required String label}) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, size: 18, color: AppColors.textSecondary),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: AppTextStyles.body.copyWith(color: AppColors.textPrimary),
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: AppColors.textSecondary),
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
