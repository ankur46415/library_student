import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// 🔍 Check if user is already linked with a student
  Future<String?> getLinkedUserId() async {
    try {
      final user = _auth.currentUser;
      if (user == null) return null;

      final userDoc = await _firestore.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        return userDoc.data()?['linkedUserId'] as String?;
      }
      return null;
    } catch (e) {
      print("❌ Error getting linkedUserId: $e");
      return null;
    }
  }

  /// 🔍 Find student by full ID (libraryId:studentId)
  Future<Map<String, String>?> findStudentById(String fullId) async {
    try {
      print("🔍 Validating student ID: $fullId");

      if (!fullId.contains(":")) {
        throw Exception("Invalid ID format. Use libraryId:studentId");
      }

      final parts = fullId.split(":");
      final libraryId = parts[0].trim();
      final studentId = parts[1].trim();

      // Direct document fetch (NO query)
      final studentDoc = await _firestore
          .collection('libraries')
          .doc(libraryId)
          .collection('students')
          .doc(studentId)
          .get();

      if (!studentDoc.exists) {
        print("⚠️ Student not found: $fullId");
        return null;
      }

      print("✅ Student found: $fullId");
      return {"libraryId": libraryId, "studentId": studentId};
    } catch (e) {
      print("❌ Error finding student: $e");
      rethrow;
    }
  }

  /// 🔗 Link student to logged-in user (first-time UID set)
  Future<bool> linkStudentToUser({
    required String libraryId,
    required String studentId,
  }) async {
    try {
      final user = _auth.currentUser;
      if (user == null) return false;

      print("🔗 Linking student $studentId to user ${user.uid}");

      // 1️⃣ Update user document
      await _firestore.collection('users').doc(user.uid).set({
        'linkedUserId': studentId,
        'libraryId': libraryId,
        'uid': user.uid,
        'email': user.email,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      // 2️⃣ Update student document (first-time UID set)
      await _firestore
          .collection('libraries')
          .doc(libraryId)
          .collection('students')
          .doc(studentId)
          .set({
            // set() with merge is safer than update() to avoid PERMISSION_DENIED
            'uid': user.uid,
            'linkedAt': FieldValue.serverTimestamp(),
          }, SetOptions(merge: true));

      print("✅ Successfully linked student $studentId to user ${user.uid}");
      return true;
    } catch (e) {
      print("❌ Error linking student: $e");
      return false;
    }
  }

  /// 👤 Get logged-in user data
  Future<Map<String, dynamic>?> getUserData() async {
    try {
      final user = _auth.currentUser;
      if (user == null) return null;

      final userDoc = await _firestore.collection('users').doc(user.uid).get();
      return userDoc.exists ? userDoc.data() : null;
    } catch (e) {
      print("❌ Error getting user data: $e");
      return null;
    }
  }

  /// 📚 Get linked student document using libraryId + studentId
  Future<Map<String, dynamic>?> getLinkedStudentData({
    required String libraryId,
    required String studentId,
  }) async {
    try {
      final doc = await _firestore
          .collection('libraries')
          .doc(libraryId)
          .collection('students')
          .doc(studentId)
          .get();

      return doc.exists ? doc.data() : null;
    } catch (e) {
      print("❌ Error getting linked student data: $e");
      return null;
    }
  }
}
