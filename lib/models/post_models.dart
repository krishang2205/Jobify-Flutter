import 'package:cloud_firestore/cloud_firestore.dart';

class PostsModel {
  String? description;
  String? location;
  String? ownderId;
  String? title;
  String? username;
  String? email;
  Timestamp? timestamp;

  PostsModel({
    this.description,
    this.location,
    this.ownderId,
    this.title,
    this.username,
    this.email,
    this.timestamp,
  });

  // ✅ Accepts a Map now instead of DocumentSnapshot
  factory PostsModel.fromMap(Map<String, dynamic> map) {
    return PostsModel(
      description: map['description'],
      location: map['location'],
      ownderId: map['ownerId'],
      timestamp: map['timestamp'],
      title: map['title'],
      username: map['username'],
      email: map['email'],
    );
  }
}
