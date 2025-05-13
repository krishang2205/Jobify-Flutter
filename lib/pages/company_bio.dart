import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iec_project/controllers/companybio_controller.dart';
import 'package:iec_project/utils/gradients.dart';

class CompanyBio extends StatefulWidget {
  const CompanyBio({super.key});

  @override
  State<CompanyBio> createState() => _CompanyBioState();
}

class _CompanyBioState extends State<CompanyBio> {
  String? name, bio, email, number;
  CompanyController dbcontroller = Get.put(CompanyController());
  File? _image;
  ImagePicker picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();

  _UserImagePicker(_ImagePicker ip) async {
    final XFile? pick;
    switch (ip) {
      case _ImagePicker.camera:
        pick = await picker.pickImage(
            source: ImageSource.camera, imageQuality: 25);
        break;
      case _ImagePicker.gallery:
        pick = await picker.pickImage(
            source: ImageSource.gallery, imageQuality: 25);
        break;
    }

    if (pick == null) {
      print("No image is selected");
      return; // Exit if no image was picked
    }

    _image = File(pick.path);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(gradient: gradeGrey),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Welcome!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Tell us about yourself!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      InkWell(
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
                                      _UserImagePicker(_ImagePicker.camera);
                                      Navigator.pop(ctx);
                                    },
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.image),
                                    title: const Text("Gallery"),
                                    onTap: () {
                                      _UserImagePicker(_ImagePicker.gallery);
                                      Navigator.pop(ctx);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(50)),
                            child: _image == null
                                ? const Icon(
                                    Icons.add_a_photo,
                                    size: 40,
                                  )
                                : kIsWeb
                                    ? Image.memory(
                                        _image!.readAsBytesSync(),
                                        fit: BoxFit.cover,
                                      )
                                    : Image.file(
                                        _image!,
                                        fit: BoxFit.cover,
                                      )),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.only(left: 20.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextFormField(
                          controller: CompanyController.instance.nameController,
                          cursorColor: const Color(0xFF2C3E50),
                          cursorWidth: 1.0,
                          decoration: const InputDecoration(
                            labelText: "Company",
                            labelStyle: TextStyle(color: Color(0xFF8E9EAB)),
                            hintText: "your name",
                            border: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "The field is empty";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            name = value;
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.only(left: 20.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextFormField(
                          maxLines: 3,
                          controller: CompanyController.instance.bioController,
                          cursorColor: const Color(0xFF2C3E50),
                          cursorWidth: 1.0,
                          decoration: const InputDecoration(
                            labelText: "Bio Description",
                            labelStyle: TextStyle(color: Color(0xFF8E9EAB)),
                            hintText: "your bio description",
                            border: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter bio";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            bio = value;
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.only(left: 20.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextFormField(
                          controller:
                              CompanyController.instance.emailController,
                          cursorColor: const Color(0xFF2C3E50),
                          cursorWidth: 1.0,
                          decoration: const InputDecoration(
                            labelText: "Email",
                            labelStyle: TextStyle(color: Color(0xFF8E9EAB)),
                            hintText: "your email",
                            border: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "The value should not be empty";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            email = value;
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.only(left: 20.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextFormField(
                          controller:
                              CompanyController.instance.contactController,
                          cursorColor: const Color(0xFF2C3E50),
                          cursorWidth: 1.0,
                          decoration: const InputDecoration(
                            labelText: "Contact",
                            labelStyle: TextStyle(color: Color(0xFF8E9EAB)),
                            hintText: "your contact no",
                            border: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "The field should not be empty";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            number = value;
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2C3E50),
                        ),
                        child: const Text(
                          "Submit",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            // Check if any required field is empty
                            if (name == null || name!.isEmpty) {
                              Get.snackbar(
                                  "Error", "Please enter company name!");
                              return;
                            }
                            if (bio == null || bio!.isEmpty) {
                              Get.snackbar(
                                  "Error", "Please enter bio description!");
                              return;
                            }
                            if (email == null || email!.isEmpty) {
                              Get.snackbar("Error", "Please enter email!");
                              return;
                            }
                            if (number == null || number!.isEmpty) {
                              Get.snackbar(
                                  "Error", "Please enter contact number!");
                              return;
                            }

                            // If no image selected, continue without uploading an image
                            if (_image != null) {
                              // Only upload image if selected
                              String url = await dbcontroller
                                  .uploadCompanyImage(_image!);
                              dbcontroller.uploadData(url);
                            } else {
                              // Upload without image
                              dbcontroller.uploadData("");
                            }
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

enum _ImagePicker { camera, gallery }
