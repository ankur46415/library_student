import 'package:get/get.dart';
import '../../services/firebase_service.dart';

class ProfileController extends GetxController {
  final FirebaseService _firebaseService = FirebaseService();

  var isLoading = true.obs;
  var errorMessage = ''.obs;

  final Rxn<Map<String, dynamic>> userData = Rxn<Map<String, dynamic>>();
  final Rxn<Map<String, dynamic>> studentData = Rxn<Map<String, dynamic>>();

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  Future<void> loadProfile() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final user = await _firebaseService.getUserData();
      if (user == null) {
        errorMessage.value = 'User data not found';
        isLoading.value = false;
        return;
      }

      userData.value = user;

      final libraryId = user['libraryId'] as String?;
      final linkedUserId = user['linkedUserId'] as String?;

      if (libraryId != null && linkedUserId != null) {
        final studentDoc = await _firebaseService
            .getLinkedStudentData(libraryId: libraryId, studentId: linkedUserId);
        if (studentDoc != null) {
          studentData.value = studentDoc;
        }
      }

      isLoading.value = false;
    } catch (e) {
      errorMessage.value = 'Failed to load profile. Please try again.';
      isLoading.value = false;
    }
  }
}


