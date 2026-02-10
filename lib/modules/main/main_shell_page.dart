import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';
import '../attendance/attendance_page.dart';
import '../home/home_page.dart';
import '../payments/payments_page.dart';
import '../profile/profile_page.dart';

class MainShellController extends GetxController {
  final currentIndex = 0.obs;
  void changeTab(int index) => currentIndex.value = index;
}

class MainShellPage extends GetView<MainShellController> {
  const MainShellPage({super.key});

  static final _pages = [
    const HomePage(),
    const AttendancePage(),
    const PaymentsPage(),
    const ProfilePage(),
  ];

  static final _items = [
    _NavItem('Home', Icons.home_rounded),
    _NavItem('Attendance', Icons.qr_code_scanner_rounded),
    _NavItem('Payments', Icons.account_balance_wallet_rounded),
    _NavItem('Profile', Icons.person_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    Get.put(MainShellController());

    return Obx(() {
      final index = controller.currentIndex.value;

      return Scaffold(
        body: _pages[index],
        bottomNavigationBar: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.only(left: 6,right: 6,bottom: 8),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 20,
                    offset: const Offset(0, -6),
                  ),
                ],
              ),
              child: Row(
                children: List.generate(_items.length, (i) {
                  final selected = index == i;
                  final item = _items[i];

                  return Expanded(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(999),
                      onTap: () => controller.changeTab(i),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.all(6),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: selected
                              ? AppColors.primarySoft
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 200),
                              child: Icon(
                                item.icon,
                                key: ValueKey(selected),
                                size: selected ? 26 : 22,
                                color: selected
                                    ? AppColors.primary
                                    : AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              item.label,
                              style: AppTextStyles.label.copyWith(
                                fontSize: 10,
                                fontWeight: selected
                                    ? FontWeight.w600
                                    : FontWeight.w500,
                                color: selected
                                    ? AppColors.primary
                                    : AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      );
    });
  }
}

class _NavItem {
  final String label;
  final IconData icon;
  const _NavItem(this.label, this.icon);
}
