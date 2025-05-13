import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iec_project/controllers/firestore_controller.dart';
import 'package:iec_project/models/user_model.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';

class CompanyRegistrationPage extends StatelessWidget {
  final FirestoreController controller = Get.put(FirestoreController());
  final _formKey = GlobalKey<FormState>();

  CompanyRegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Company Registration'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Company Name Field
              TextFormField(
                controller: controller.nameController,
                decoration: const InputDecoration(
                  labelText: 'Company Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.business),
                ),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 20),

              // Company Specialization Field
              TextFormField(
                controller: controller.specializationController,
                decoration: const InputDecoration(
                  labelText: 'Company Specialization',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 20),

              // Company Bio Field
              TextFormField(
                controller: controller.bioController,
                decoration: const InputDecoration(
                  labelText: 'Company Bio',
                  border: OutlineInputBorder(),
                  hintText: 'Tell us about your company',
                ),
                maxLines: 3,
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 20),

              // Dropdown for Years of Experience
              DropDownTextField(
                dropDownList: const [
                  DropDownValueModel(name: '0-1 years', value: "0"),
                  DropDownValueModel(name: '1-3 years', value: "1"),
                  DropDownValueModel(name: '3-5 years', value: "3"),
                  DropDownValueModel(name: '5+ years', value: "5"),
                ],
                controller: controller.expController!,
                clearOption: true,
                enableSearch: true,
                textFieldDecoration: const InputDecoration(
                  labelText: 'Years of Experience',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null ? 'Required' : null,
              ),
              const SizedBox(height: 30),

              // Submit Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2C3E50),
                ),
                child: const Text(
                  "Register Company",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Ensure that the dropdown value is selected and handle text inputs properly
                    controller.registerCompany(
                      controller.nameController!.text,
                      controller.specializationController!.text,
                      controller.expController?.dropDownValue?.value ??
                          '0', // Default to '0' if null
                      controller.bioController!.text,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
