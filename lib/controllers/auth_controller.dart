import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:iec_project/pages/introduction.dart';

class Authcontroller {
  static Authcontroller instance = Authcontroller();
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> signInWithGoogle() async {
    try {
      if (kIsWeb) {
      
        final GoogleAuthProvider googleProvider = GoogleAuthProvider();
        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithPopup(googleProvider);
        return userCredential.user;
      } else {
        // Use GoogleSignIn for mobile platforms
        final GoogleSignIn googleSignIn = GoogleSignIn();
        final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
        if (googleUser == null) {
          // User canceled the sign-in
          Get.snackbar(
            "Error",
            "Google Sign-In was canceled.",
            snackPosition: SnackPosition.BOTTOM,
          );
          return null;
        }

        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );

        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        return userCredential.user;
      }
    } catch (e) {
      print("Error during Google Sign-In: $e");
      Get.snackbar(
        "Error",
        "Google Sign-In failed: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      print("Error during sign-up: $e");
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      print("User signed in successfully");
    } catch (e) {
      print("Error during sign-in: $e");
    }
  }

  Future<void> signOut() async {
    try {
      await auth.signOut();
      Get.snackbar(
        "Success",
        "You have been signed out successfully.",
        snackPosition: SnackPosition.BOTTOM,
      );
      Get.offAll(() =>
          const IntroductionScreen()); // Navigate to IntroductionScreen after logout
    } catch (e) {
      print("Error during sign-out: $e");
      Get.snackbar(
        "Error",
        "Sign-out failed: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
