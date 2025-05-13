import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iec_project/controllers/auth_controller.dart';
import 'package:iec_project/controllers/getCurrentUserPost.dart';

import 'package:iec_project/utils/info_box.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  File? _image;
  bool doce = false;
  final GetCurrentPostsController _getCurrentPostsController =
      Get.put(GetCurrentPostsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.all(20.0),
          child: Row(
            children: [
              Text(
                'User',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                ' Profile',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        elevation: 0.0,
        titleSpacing: 0.0,
        backgroundColor: Colors.white,
        actionsIconTheme: const IconThemeData(color: Colors.black),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                width: double.infinity,
                height: 2,
                color: Colors.grey[300],
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        if (_image == null) return;
                        await showDialog(
                          context: context,
                          builder: (ctx) {
                            return Dialog(
                              backgroundColor: Colors.black,
                              child: Container(
                                width: MediaQuery.of(context).size.width - 50,
                                height: MediaQuery.of(context).size.height - 80,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: FileImage(_image!),
                                      fit: BoxFit.contain),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: CircleAvatar(
                        radius: 50,
                        foregroundImage: _profilePicture(),
                        backgroundColor: const Color(0xFF2C5364),
                        child: _image != null && kIsWeb
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.memory(
                                  _image!.readAsBytesSync(),
                                  fit: BoxFit.cover,
                                  width: 100,
                                  height: 100,
                                ),
                              )
                            : const Icon(
                                Icons.supervised_user_circle,
                                size: 100,
                                color: Colors.white,
                              ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: InkResponse(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (ctx) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    leading: const Icon(Icons.camera_alt),
                                    title: const Text("Camera"),
                                    onTap: () {
                                      _imagePicker(_ImagePicker.camera);
                                      Navigator.pop(ctx);
                                    },
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.image),
                                    title: const Text("Gallery"),
                                    onTap: () {
                                      _imagePicker(_ImagePicker.gallery);
                                      Navigator.pop(ctx);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 3,
                                color: Colors.white,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(
                                  50,
                                ),
                              ),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  offset: const Offset(2, 4),
                                  color: Colors.black.withOpacity(
                                    0.3,
                                  ),
                                  blurRadius: 3,
                                ),
                              ]),
                          child: const Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Icon(
                              Icons.add_a_photo,
                              size: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          FirebaseAuth.instance.currentUser!.displayName!,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          FirebaseAuth.instance.currentUser!.email!,
                          style: const TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40.0),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "User Posts",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            Expanded(
              child: GetBuilder<GetCurrentPostsController>(
                init: GetCurrentPostsController(),
                builder: (controller) {
                  controller.getPosts();
                  return controller.isLoading
                      ? ListView.builder(
                          itemCount: controller.currentposts.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                shadowColor: Colors.blueGrey[600],
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      ListTile(
                                        leading: const CircleAvatar(),
                                        title: Text(
                                          controller
                                              .currentposts[index].username!,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(controller
                                            .currentposts[index].email!),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10)),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              children: [
                                                Text(controller
                                                    .currentposts[index]
                                                    .description!),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Container(
                                                      child: Row(
                                                        children: [
                                                          const Icon(
                                                            CupertinoIcons
                                                                .location_solid,
                                                            color: Color(
                                                                0xFF2C5364),
                                                          ),
                                                          Text(controller
                                                              .currentposts[
                                                                  index]
                                                              .location!),
                                                        ],
                                                      ),
                                                    ),
                                                    (controller.uid !=
                                                            controller
                                                                .currentposts[
                                                                    index]
                                                                .ownderId)
                                                        ? ElevatedButton(
                                                            style: ButtonStyle(
                                                                backgroundColor:
                                                                    WidgetStateProperty.all(
                                                                        const Color(
                                                                            0xFF2C5364))),
                                                            onPressed: () {},
                                                            child: const Text(
                                                                "Send CV"))
                                                        : const Text("")
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })
                      : const Center(
                          child: Text("You don't have posts"),
                        );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  _imagePicker(_ImagePicker ip) async {
    final ImagePicker picker = ImagePicker();
    XFile? img;

    try {
      switch (ip) {
        case _ImagePicker.camera:
          img = await picker.pickImage(source: ImageSource.camera);
          break;
        case _ImagePicker.gallery:
          img = await picker.pickImage(source: ImageSource.gallery);
          break;
      }

      if (img == null) {
        print("No image selected");
        return;
      }

      if (kIsWeb) {
        // For web, we can't use the same cropping approach
        // We'll just use the picked image directly
        setState(() {
          final bytes = img!.readAsBytes();
          bytes.then((value) => _image = File.fromRawPath(value));
        });
      } else {
        // For native platforms, use ImageCropper as before
        CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: img.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
          ],
          uiSettings: [
            AndroidUiSettings(
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false,
            ),
          ],
        );

        if (croppedFile != null) {
          setState(() {
            _image = File(croppedFile.path);
          });
        }
      }

      // Only update photo URL if image was successfully selected/cropped
      if (_image != null) {
        FirebaseAuth.instance.currentUser!.updatePhotoURL(
          await uploadImage(_image!),
        );
      }
    } catch (e) {
      print("Error picking or cropping image: $e");
    }
  }

  _profilePicture() {
    if (FirebaseAuth.instance.currentUser!.photoURL != null &&
        FirebaseAuth.instance.currentUser!.photoURL!.isNotEmpty) {
      return NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!);
    } else if (_image != null) {
      if (kIsWeb) {
        return null;
      } else {
        return FileImage(_image!);
      }
    } else {
      return null;
    }
  }

  Future<String> uploadImage(File image) async {
    try {
      // Replace this with your actual image upload logic
      // and return the URL of the uploaded image
      print("Image uploaded successfully");
      return "https://example.com/uploaded_image.jpg"; // Example URL
    } catch (e) {
      print("Error during image upload: $e");
      return "";
    }
  }
}

enum _ImagePicker {
  camera,
  gallery,
}
