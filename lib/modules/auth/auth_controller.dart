import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../routes/app_routes.dart';
import '../../services/firebase_service.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
    signInOption: SignInOption.standard, // forces account selection popup
  );
  final FirebaseService _firebaseService = FirebaseService();

  var isLoading = false.obs;

  /// Google Sign-In
  Future<void> signInWithGoogle() async {
    try {
      print("🚀 Google Sign-In started");
      isLoading.value = true;

      // Clear previous account so user can choose
      await _googleSignIn.signOut();
      print("🔄 Cleared cached Google account");

      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      print("👤 Google user selected: $googleUser");

      if (googleUser == null) {
        // User canceled the sign-in
        print("❌ User cancelled Google Sign-In");
        return;
      }

      // Obtain auth details
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      print("🔑 Google authentication tokens obtained");
      print("Access Token: ${googleAuth.accessToken}");
      print("ID Token: ${googleAuth.idToken}");

      // Create Firebase credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      print("🔐 Firebase credential created");

      // Sign in to Firebase
      final userCredential = await _auth.signInWithCredential(credential);
      print("✅ Firebase sign-in successful: ${userCredential.user?.email}");

      // Check if user has linkedUserId
      final linkedUserId = await _firebaseService.getLinkedUserId();

      if (linkedUserId != null && linkedUserId.isNotEmpty) {
        // User already linked, go directly to home
        print("✅ User already linked with student ID: $linkedUserId");
        Get.offAllNamed(AppRoutes.main);
        print("🏠 Navigated to main (home)");
      } else {
        // User not linked, show link student page
        print("⚠️ User not linked, showing link student page");
        Get.offAllNamed(AppRoutes.linkStudent);
        print("🎓 Navigated to link student page");
      }
    } catch (e) {
      print("⚠️ Google Sign-In error: $e");
      Get.snackbar('Error', 'Failed to sign in with Google: $e');
    } finally {
      isLoading.value = false;
      print("⏹️ Google Sign-In finished");
    }
  }

  /// Google Sign-Out
  Future<void> signOut() async {
    try {
      print("🚪 Signing out from Google and Firebase...");
      isLoading.value = true;

      await _googleSignIn.signOut();
      await _auth.signOut();

      print("✅ Sign-out successful");

      // Navigate to login route
      Get.offAllNamed(AppRoutes.login);
      print("🏠 Navigated to login route");
    } catch (e) {
      print("⚠️ Sign-out error: $e");
      Get.snackbar('Error', 'Failed to sign out: $e');
    } finally {
      isLoading.value = false;
      print("⏹️ Sign-out finished");
    }
  }
}
