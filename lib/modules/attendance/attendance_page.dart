import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';

class AttendancePage extends StatelessWidget {
  const AttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Attendance', style: AppTextStyles.subheading),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: Column(
          children: [
            _markAttendanceCard(),
            const SizedBox(height: 16),
            _historyCard(),
          ],
        ),
      ),
    );
  }

  Widget _markAttendanceCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary.withOpacity(0.95), AppColors.primary.withOpacity(0.8)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.25),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          const Icon(Icons.qr_code_scanner_rounded, color: Colors.white, size: 44),
          const SizedBox(height: 8),
          const Text('Mark Attendance',
              style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          const Text(
            'Scan QR or tap below after reaching library.',
            style: TextStyle(color: Colors.white70, fontSize: 13),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(Icons.qr_code_rounded, size: 60, color: Colors.white),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.check_circle_outline_rounded),
              label: const Text('Mark Present', style: TextStyle(fontWeight: FontWeight.w600)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Late after 09:30 AM • Auto absent if not marked',
            style: TextStyle(color: Colors.white70, fontSize: 11),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _historyCard() {
    final days = [
      _Day('Mon', '10', true),
      _Day('Tue', '11', true),
      _Day('Wed', '12', false),
      _Day('Thu', '13', true),
      _Day('Fri', '14', true),
      _Day('Sat', '15', false),
      _Day('Sun', '16', false),
    ];
    final presentCount = days.where((e) => e.present).length;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('This Week', style: AppTextStyles.subheading),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  '$presentCount/7 Present',
                  style: const TextStyle(color: AppColors.success, fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: days.map(_dayTile).toList(),
          ),
        ],
      ),
    );
  }

  Widget _dayTile(_Day e) {
    return Column(
      children: [
        Text(e.day, style: AppTextStyles.label),
        const SizedBox(height: 4),
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: e.present ? AppColors.success.withOpacity(0.12) : AppColors.danger.withOpacity(0.08),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Icon(e.present ? Icons.check_rounded : Icons.close_rounded,
              size: 16, color: e.present ? AppColors.success : AppColors.danger),
        ),
      ],
    );
  }
}

class _Day {
  final String day;
  final String date;
  final bool present;

  _Day(this.day, this.date, this.present);
}
