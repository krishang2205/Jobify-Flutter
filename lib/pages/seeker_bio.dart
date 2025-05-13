import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:iec_project/controllers/auth_controller.dart';
import 'package:iec_project/controllers/seekerUpload_controller.dart';
import 'package:iec_project/models/user_model.dart';
import 'package:iec_project/utils/gradients.dart';
import 'package:image_picker/image_picker.dart';

class SeekerBio extends StatefulWidget {
  const SeekerBio({super.key});

  @override
  State<SeekerBio> createState() => _SeekerBioState();
}

class _SeekerBioState extends State<SeekerBio> {
  Seekers? seekers;
  dynamic expValue;
  String? name, bio, email, number;
  final SeekerUploadController _seekController =
      Get.put(SeekerUploadController());

  File? _image;
  ImagePicker picker = ImagePicker();

  final _formKey = GlobalKey<FormState>();
  int index = 0;

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

    // Safely accessing the path of the selected image
    if (pick != null && pick.path.isNotEmpty) {
      _image = File(pick.path); // Only assign the path if pick is not null
    } else {
      print("No image is selected");
    }
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
                      const SizedBox(
                        height: 20,
                      ),
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
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 20.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextFormField(
                          controller: _seekController.nameController,
                          cursorColor: const Color(0xFF2C3E50),
                          cursorWidth: 1.0,
                          decoration: const InputDecoration(
                            labelText: "Name",
                            labelStyle: TextStyle(color: Color(0xFF8E9EAB)),
                            hintText: "your name",
                            border: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "the field is empty";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            name = value;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 20.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextFormField(
                          maxLines: 3,
                          controller: _seekController.bioController,
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
                      const SizedBox(
                        height: 20,
                      ),
                      DropDownTextField(
                        dropdownRadius: 18,
                        textFieldDecoration: InputDecoration(
                            border: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: "enter experience",
                            labelStyle: const TextStyle(color: Colors.grey)),
                        controller: _seekController.expController,
                        dropDownList: const [
                          DropDownValueModel(name: "1 year", value: "value 1"),
                          DropDownValueModel(name: "2 years", value: "value 2"),
                          DropDownValueModel(name: "3 years", value: "value 3"),
                          DropDownValueModel(name: "4 years", value: "value 4"),
                          DropDownValueModel(name: "5 years", value: "value 5"),
                        ],
                        onChanged: (value) {
                          expValue = _seekController
                              .expController!.dropDownValue!.name;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      DropDownTextField.multiSelection(
                        controller: _seekController.mController,
                        dropDownList: const [
                          DropDownValueModel(name: "Java", value: "selOne"),
                          DropDownValueModel(name: "Flutter", value: "SelTwo"),
                          DropDownValueModel(
                              name: "Android", value: "selThree"),
                          DropDownValueModel(
                              name: "React.js", value: "selFour"),
                          DropDownValueModel(
                              name: "React Native", value: "selFive"),
                          DropDownValueModel(name: "Node JS", value: "selSix"),
                          DropDownValueModel(name: "Python", value: "selSeven"),
                          DropDownValueModel(name: "Dart", value: "selEight"),
                          DropDownValueModel(name: "AWS", value: "selNine"),
                          DropDownValueModel(name: "Azure", value: "selTen"),
                          DropDownValueModel(
                              name: "Docker", value: "selEleven"),
                        ],
                        textFieldDecoration: InputDecoration(
                            labelText: "enter skills ",
                            labelStyle: const TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: Colors.white,
                            border: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(30))),
                        onChanged: (value) {},
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 20.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextFormField(
                          controller: _seekController.emailController,
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
                              return "the value should not be empty";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            email = value;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 20.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextFormField(
                          controller: _seekController.contactController,
                          cursorColor: const Color(0xFF2C3E50),
                          cursorWidth: 1.0,
                          decoration: const InputDecoration(
                            labelText: "contact",
                            labelStyle: TextStyle(color: Color(0xFF8E9EAB)),
                            hintText: "your contact no",
                            border: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "the field should not be empty";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            number = value;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  WidgetStateProperty.all(Colors.grey[600])),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              for (var element in _seekController
                                  .mController!.dropDownValueList!) {
                                _seekController.skills
                                    .add(element.name.toString());
                              }
                              String url = _image != null
                                  ? await _seekController
                                      .uploadUserImage(_image!)
                                  : ''; // If no image is selected, use an empty string

                              _seekController.uploadData(url);
                            }
                          },
                          child: _seekController.isUploading.isTrue
                              ? const Center(
                                  child: CircularProgressIndicator(
                                  color: Colors.white,
                                ))
                              : const Text(
                                  'Save and Continue',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
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
