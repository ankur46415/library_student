import 'package:get/get.dart';
import '../modules/auth/login/login_page.dart';
import '../modules/auth/otp/otp_page.dart';
import '../modules/auth/link_student/link_student_page.dart';
import '../modules/main/main_shell_page.dart';
import '../modules/splash/splash_page.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashPage(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: AppRoutes.otp,
      page: () => const OtpPage(),
    ),
    GetPage(
      name: AppRoutes.linkStudent,
      page: () => const LinkStudentPage(),
    ),
    GetPage(
      name: AppRoutes.main,
      page: () => const MainShellPage(),
    ),
  ];
}


