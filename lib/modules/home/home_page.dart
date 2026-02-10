import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hi, Ankit 👋', style: AppTextStyles.subheading),
              const SizedBox(height: 2),
              Text('Reader’s Paradise Library', style: AppTextStyles.label),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: AppColors.primarySoft,
              child: const Icon(Icons.person_outline, color: AppColors.primary, size: 20),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _todayStatusCard(),
            const SizedBox(height: 16),
            _quickActions(),
            const SizedBox(height: 16),
            _planCard(),
            const SizedBox(height: 16),
            _alertsSection(),
          ],
        ),
      ),
    );
  }

  Widget _todayStatusCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary.withOpacity(0.95), AppColors.primary.withOpacity(0.8)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.25), blurRadius: 16, offset: const Offset(0, 8))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text('Today', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
            _statusChip(),
          ]),
          const SizedBox(height: 14),
          Row(children: [_infoTileWhite('Check-in', '07:42 AM'), const SizedBox(width: 10), _infoTileWhite('Seat', 'A-12')]),
          const SizedBox(height: 10),
          Row(children: [_infoTileWhite('Timing', 'Morning'), const SizedBox(width: 10), _infoTileWhite('Plan', 'Monthly')]),
        ],
      ),
    );
  }

  Widget _statusChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(999)),
      child: Row(children: const [
        Text('Present', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
        SizedBox(width: 6),
        CircleAvatar(radius: 3, backgroundColor: Colors.white),
      ]),
    );
  }

  Widget _infoTileWhite(String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(14)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label, style: const TextStyle(color: Colors.white70, fontSize: 11)),
          const SizedBox(height: 2),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
        ]),
      ),
    );
  }

  Widget _quickActions() {
    return Row(
      children: [
        _actionBtn(Icons.qr_code_scanner, 'Scan QR'),
        const SizedBox(width: 10),
        _actionBtn(Icons.payments_outlined, 'Pay Fees'),
        const SizedBox(width: 10),
        _actionBtn(Icons.receipt_long_outlined, 'History'),
      ],
    );
  }

  Widget _actionBtn(IconData icon, String text) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, 6))],
        ),
        child: Column(children: [Icon(icon, color: AppColors.primary), const SizedBox(height: 4), Text(text, style: AppTextStyles.label)]),
      ),
    );
  }

  Widget _planCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 16, offset: const Offset(0, 8))],
      ),
      child: Row(children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: AppColors.primarySoft, borderRadius: BorderRadius.circular(16)),
          child: const Icon(Icons.calendar_month_rounded, color: AppColors.primary),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Plan active', style: AppTextStyles.label),
            const SizedBox(height: 2),
            Text('Valid till 28 Feb 2026', style: AppTextStyles.subheading),
          ]),
        ),
        const Icon(Icons.chevron_right_rounded, color: AppColors.textSecondary),
      ]),
    );
  }

  Widget _alertsSection() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Alerts', style: AppTextStyles.subheading),
      const SizedBox(height: 10),
      _alertCard(emoji: '⏰', title: 'Attendance not marked', subtitle: 'Don’t forget to scan QR after reaching library.', color: AppColors.warning),
      const SizedBox(height: 10),
      _alertCard(emoji: '⚠️', title: 'Fee due in 3 days', subtitle: 'Next payment date: 25 Feb 2026.', color: AppColors.warning),
    ]);
  }

  Widget _alertCard({required String emoji, required String title, required String subtitle, required Color color}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 12, offset: const Offset(0, 6))],
      ),
      child: Row(children: [
        Text(emoji, style: const TextStyle(fontSize: 22)),
        const SizedBox(width: 8),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: AppTextStyles.subheading.copyWith(fontSize: 14, color: color)),
            const SizedBox(height: 2),
            Text(subtitle, style: AppTextStyles.body),
          ]),
        ),
      ]),
    );
  }
}
