import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:iec_project/utils/constants.dart';

class AuthService {
  Future<User?> signUp(String email, password, BuildContext context) async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      String message = 'An error occurred';
      if (e.code == 'weak-password') {
        message = 'Password must be at least 6 characters';
      } else if (e.code == 'email-already-in-use') {
        message = 'This email is already registered';
      } else if (e.code == 'invalid-email') {
        message = 'Invalid email format';
      }
      Get.snackbar('Error', message,
          snackPosition: SnackPosition.BOTTOM, duration: const Duration(seconds: 3));
    } catch (e) {
      Get.snackbar('Error', 'Unexpected error occurred',
          snackPosition: SnackPosition.BOTTOM);
    }
    return null;
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', 'Sign out failed: ${e.message}',
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', 'Unexpected error during sign out',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
