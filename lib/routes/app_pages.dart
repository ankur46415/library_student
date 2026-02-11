import 'package:get/get.dart';
import '../modules/auth/auth_controller.dart';
import '../modules/auth/login/login_page.dart';
import '../modules/auth/link_student/link_student_page.dart';
import '../modules/auth/link_student/link_student_controller.dart';
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
      binding: BindingsBuilder(() {
        Get.lazyPut<AuthController>(() => AuthController());
      }),
    ),
    GetPage(
      name: AppRoutes.linkStudent,
      page: () => const LinkStudentPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<LinkStudentController>(() => LinkStudentController());
      }),
    ),
    GetPage(
      name: AppRoutes.main,
      page: () => const MainShellPage(),
    ),
  ];
}


