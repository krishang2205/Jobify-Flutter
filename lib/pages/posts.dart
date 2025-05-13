import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iec_project/controllers/getpost_controller.dart';
import 'package:iec_project/controllers/post_controller.dart';
import 'package:iec_project/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class Posts extends StatefulWidget {
  const Posts({super.key});

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  final PostController _postController = Get.put(PostController());
  final GetPostsController _getPostsController = Get.put(GetPostsController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        floatingActionButton: (_postController.checkdoc)
            ? FloatingActionButton.extended(
                label: const Text(
                  'Create',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: const Color(0xFF2C3E50),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (ctx) {
                      return SingleChildScrollView(
                        child: Container(
                          padding: const EdgeInsets.all(12.0),
                          height: MediaQuery.of(context).size.height * 0.7,
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Post',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              TextFormField(
                                controller: _postController.title,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                  hintText: "title",
                                  labelText: "enter title",
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              Container(
                                padding: const EdgeInsets.only(left: 15.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                      color: const Color(0xFFABBAAB),
                                      width: 1.0),
                                ),
                                child: TextFormField(
                                  controller: _postController.desc,
                                  decoration: const InputDecoration(
                                    hintText: "Start typing...",
                                    border: InputBorder.none,
                                  ),
                                  minLines: 6,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  cursorColor: const Color(0xFF2C3E50),
                                  cursorWidth: 1.0,
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: _postController.Loc,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                  hintText: "Location",
                                  labelText: "Enter location",
                                ),
                              ),
                              const SizedBox(height: 20),
                              Center(
                                child: ElevatedButton(
                                  onPressed: () =>
                                      _postController.uploadPost(context),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF2C3E50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  child: const Text(
                                    'Upload Post',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                icon: const Icon(Icons.add),
              )
            : null,
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.all(20.0),
            child: Row(
              children: [
                Text(
                  'Company',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  ' Posts',
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
        body: Center(
          child: Column(
            children: [
              Expanded(
                child: GetBuilder<GetPostsController>(
                  init: GetPostsController(),
                  builder: (controller) {
                    controller.getPosts();

                    return controller.isLoading
                        ? ListView.builder(
                            itemCount: controller.posts.length,
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
                                          title: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                controller.posts[index].title!,
                                                // Display the job title
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                controller
                                                    .posts[index].username!,
                                                // Display the company name
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                          subtitle: Text(
                                              controller.posts[index].email!),
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
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Column(
                                                children: [
                                                  Text(controller.posts[index]
                                                      .description!),
                                                  const SizedBox(height: 20),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          const Icon(
                                                            CupertinoIcons
                                                                .location_solid,
                                                            color: Color(
                                                                0xFF2C5364),
                                                          ),
                                                          Text(controller
                                                              .posts[index]
                                                              .location!),
                                                        ],
                                                      ),
                                                      (controller.uid !=
                                                              controller
                                                                  .posts[index]
                                                                  .ownderId)
                                                          ? ElevatedButton(
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                backgroundColor:
                                                                    const Color(
                                                                        0xFF2C3E50),
                                                              ),
                                                              child: const Text(
                                                                'Send CV',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              onPressed:
                                                                  () async {
                                                                String email =
                                                                    controller
                                                                        .posts[
                                                                            index]
                                                                        .email!;
                                                                String subject =
                                                                    Uri.encodeComponent(
                                                                        "Hello Flutter");
                                                                String body = Uri
                                                                    .encodeComponent(
                                                                        "Hi! I'm ${_postController.jobTitleController.text}");
                                                                String
                                                                    gmailUrl =
                                                                    "https://mail.google.com/mail/?view=cm&fs=1&to=$email&su=$subject&body=$body";

                                                                if (await canLaunchUrl(
                                                                    Uri.parse(
                                                                        gmailUrl))) {
                                                                  await launchUrl(
                                                                      Uri.parse(
                                                                          gmailUrl),
                                                                      mode: LaunchMode
                                                                          .externalApplication);
                                                                } else {
                                                                  Get.snackbar(
                                                                    "Error",
                                                                    "Could not open Gmail.",
                                                                    snackPosition:
                                                                        SnackPosition
                                                                            .BOTTOM,
                                                                  );
                                                                }
                                                              },
                                                            )
                                                          : const SizedBox(),
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
                            },
                          )
                        : const Center(
                            child: CircularProgressIndicator(),
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
