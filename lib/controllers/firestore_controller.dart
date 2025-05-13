import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';// Add this import for dropdown controllers
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:iec_project/models/user_model.dart';
import 'package:iec_project/models/company_model.dart';


class FirestoreController extends GetxController {
  static FirestoreController instance = Get.find();

  bool isLoading = false;

  TextEditingController? nameController,
      bioController,
      skillController,
      contactController,
      emailController,
      specializationController;

  SingleValueDropDownController? expController;
  MultiValueDropDownController? mController;

  List<String> skills = [];
  late FirebaseFirestore reference;

  List<Seekers> seekers = <Seekers>[];
  List<Seekers> searchedSeekers = <Seekers>[];

  QuerySnapshot? searchresults;
  String? uid;

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    bioController = TextEditingController();
    skillController = TextEditingController();
    contactController = TextEditingController();
    emailController = TextEditingController();
    expController = SingleValueDropDownController(); // Initialize the dropdown controller
    mController = MultiValueDropDownController(); // Initialize the multi-value dropdown controller
    reference = FirebaseFirestore.instance;
    uid = FirebaseAuth.instance.currentUser?.uid;
  }

  /// ✅ Fetches all data from Firestore safely
  Future<void> getdata() async {
    try {
      // Get both seekers and companies data
      QuerySnapshot seekersSnapshot =
          await reference.collection('seekers').get();
      QuerySnapshot companiesSnapshot =
          await reference.collection('companies').get();
      seekers.clear();

      // Process companies data
      final companies = companiesSnapshot.docs
          .map((doc) => Company.fromDocument(doc)) // Fixed 'Company' model
          .toList();

      for (var doc in seekersSnapshot.docs) {
        final raw = doc.data();
        if (raw == null || raw is! Map<String, dynamic>) continue;

        seekers.add(Seekers(
          name: raw['name'] ?? 'No name',
          bio: raw.containsKey('bio') ? raw['bio'] ?? '' : '',
          experience:
              raw.containsKey('experience') ? raw['experience'] ?? '0' : '0',
          skills: List<String>.from(raw['skills'] ?? []),
          email: raw['email'] ?? '',
          contact: raw['number'] ?? '',
          url: raw['url'] ?? '',
        ));
      }

      isLoading = true;
      update();
    } catch (e) {
      isLoading = false;
      Get.snackbar('Error loading data', e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  /// ✅ Searches for data by name from Firestore safely
  Future<void> searching_Data(String query) async {
    try {
      searchedSeekers.clear();

      QuerySnapshot snapshot = await reference
          .collection('seekers')
          .where('name', isGreaterThanOrEqualTo: query)
          .get();

      searchresults = snapshot;

      for (var doc in snapshot.docs) {
        final raw = doc.data();
        if (raw == null || raw is! Map<String, dynamic>) continue;

        searchedSeekers.add(Seekers(
          name: raw['name'] ?? '',
          bio: raw.containsKey('bio') ? raw['bio'] ?? '' : '',
          experience:
              raw.containsKey('experience') ? raw['experience'] ?? '' : '',
          skills: List<String>.from(raw['skills'] ?? []),
          email: raw['email'] ?? '',
          contact: raw['number'] ?? '',
          url: raw['url'] ?? '',
        ));
      }

      update();
    } catch (e) {
      Get.snackbar('Error during search', e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  /// ✅ Registers company data to Firestore
  Future<void> registerCompany(
      String name, String specialization, String experience, String bio) async {
    try {
      await FirebaseFirestore.instance.collection('companies').add({
        'name': name,
        'specialization': specialization,
        'experience': experience,
        'bio': bio,
        'createdAt': FieldValue.serverTimestamp(),
      });
      Get.back();
      Get.snackbar('Success', 'Company registered successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to register company: $e');
    }
  }
}
