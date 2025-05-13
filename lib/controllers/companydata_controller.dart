import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:iec_project/models/company_model.dart'; // Ensure this import exists

class CompanyData extends GetxController {
  String? uid;
  late FirebaseFirestore reference;
  List<Company> companies = <Company>[]; // Changed 'Companies' to 'Company'
  bool isloading = false;

  @override
  void onInit() {
    super.onInit();
    uid = FirebaseAuth.instance.currentUser!.uid;
    reference = FirebaseFirestore.instance;
  }

  Future<void> getData() async {
    try {
      QuerySnapshot words = await reference.collection("companies").get();
      companies.clear();

      for (var word in words.docs) {
        companies.add(Company.fromDocument(word)); // Changed 'Companies' to 'Company'
      }

      isloading = true;
      update();
    } catch (e) {
      Get.snackbar('error', e.toString());
    }
  }
}
