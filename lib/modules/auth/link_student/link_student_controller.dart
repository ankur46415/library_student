import 'package:get/get.dart';
import '../../../routes/app_routes.dart';
import '../../../services/firebase_service.dart';

class LinkStudentController extends GetxController {
  final FirebaseService _firebaseService = FirebaseService();

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  /// Validate and link student ID
  Future<bool> linkStudent(String studentId) async {
    if (studentId.trim().isEmpty) {
      errorMessage.value = 'Please enter Student ID';
      Get.snackbar('Error', 'Please enter Student ID');
      return false;
    }

    try {
      isLoading.value = true;
      errorMessage.value = '';

      print("🔍 Validating student ID: $studentId");

      // Find student in Firebase
      final studentData = await _firebaseService.findStudentById(studentId.trim());

      if (studentData == null) {
        errorMessage.value = 'Student ID not found. Please check and try again.';
        Get.snackbar('Error', 'Student ID not found. Please check and try again.');
        isLoading.value = false;
        return false;
      }

      print("✅ Student found: ${studentData['libraryId']}/${studentData['studentId']}");

      // Link student to user
      final success = await _firebaseService.linkStudentToUser(
        libraryId: studentData['libraryId']!,
        studentId: studentData['studentId']!,
      );

      if (success) {
        print("✅ Student linked successfully");
        isLoading.value = false;
        
        // Navigate to home
        Get.offAllNamed(AppRoutes.main);
        Get.snackbar('Success', 'Account linked successfully!');
        return true;
      } else {
        errorMessage.value = 'Failed to link account. Please try again.';
        Get.snackbar('Error', 'Failed to link account. Please try again.');
        isLoading.value = false;
        return false;
      }
    } catch (e) {
      print("❌ Error linking student: $e");
      final errorMsg = e.toString().contains('Connection') || e.toString().contains('connection')
          ? 'Connection error. Please check your internet connection and try again.'
          : 'An error occurred: ${e.toString().replaceAll('Exception: ', '')}';
      
      errorMessage.value = errorMsg;
      Get.snackbar('Error', errorMsg);
      isLoading.value = false;
      return false;
    }
  }
}

