import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:iec_project/models/post_models.dart';

class GetPostsController extends GetxController {
  List<PostsModel> posts = [];
  CollectionReference? postRef;
  bool isLoading = true; // Start in loading state
  String? uid;

  @override
  void onInit() {
    super.onInit();
    postRef = FirebaseFirestore.instance.collection('CompanyPosts');

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      uid = user.uid;
    } else {
      Get.snackbar("Error", "User not logged in.");
    }

    getPosts(); // ✅ Automatically fetch posts on controller load
  }

  Future<void> getPosts() async {
    try {
      isLoading = true;
      update();

      QuerySnapshot snapshot = await postRef!.get();
      posts.clear();

      for (var doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        posts.add(PostsModel.fromMap(data)); // ✅ CORRECT WAY
      }

      isLoading = false;
      update();
    } catch (e) {
      isLoading = false;
      update();
      Get.snackbar("Error", e.toString());
    }
  }
}
