import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';
import '../../routes/app_routes.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Profile', style: AppTextStyles.subheading),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _header(),
            const SizedBox(height: 14),
            _infoCard(),
            const SizedBox(height: 14),
            _settingsCard(),
          ],
        ),
      ),
    );
  }

  Widget _header() {
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
        Text('Ankit Sharma', style: AppTextStyles.subheading.copyWith(fontSize: 18)),
        const SizedBox(height: 2),
        Text('Seat A‑12 • Reader’s Paradise', style: AppTextStyles.body.copyWith(fontSize: 13, color: AppColors.textSecondary)),
      ],
    );
  }

  Widget _infoCard() {
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
          _infoRow('Mobile number', '+91 98xx xxxx xx'),
          const Divider(height: 20),
          _infoRow('Library name', 'Reader’s Paradise Library'),
          const Divider(height: 20),
          _infoRow('Plan type', 'Monthly'),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyles.label.copyWith(fontSize: 13, color: AppColors.textSecondary)),
        Text(value, style: AppTextStyles.subheading.copyWith(fontSize: 14)),
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
            onPressed: () => Get.offAllNamed(AppRoutes.login),
            icon: const Icon(Icons.logout_rounded, color: AppColors.danger),
            label: const Text('Logout', style: TextStyle(color: AppColors.danger, fontWeight: FontWeight.w600)),
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
              child: Text(label, style: AppTextStyles.body.copyWith(color: AppColors.textPrimary)),
            ),
            const Icon(Icons.chevron_right_rounded, color: AppColors.textSecondary),
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
