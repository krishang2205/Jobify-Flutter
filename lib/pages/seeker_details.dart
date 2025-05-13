import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SeekerDetails extends StatelessWidget {
  const SeekerDetails({super.key});

  @override
  Widget build(BuildContext context) {
    dynamic argumentData = Get.arguments;
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Image.network(
                    argumentData[0]['url'],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Name : ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(argumentData[1]['name'].toString()),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "email : ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(argumentData[2]['email'].toString()),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "bio description : ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(argumentData[3]['bio'].toString()),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Skills : ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(argumentData[4]['skills'].toString()),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Experience : ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(argumentData[5]['exp'].toString()),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "contact : ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(argumentData[6]['contact'].toString()),
            ],
          ),
        ),
      ),
    ));
  }
}
