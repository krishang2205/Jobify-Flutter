import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  int? albumId;
  int? id;
  String? title;
  String? url;
  String? thumbnailUrl;

  UserModel({this.albumId, this.id, this.title, this.url, this.thumbnailUrl});

  UserModel.fromJson(Map<String, dynamic> json) {
    albumId = json["albumId"];
    id = json["id"];
    title = json["title"];
    url = json["url"];
    thumbnailUrl = json["thumbnailUrl"];
  }
}

class Seekers {
  String? name;
  String? bio;
  String? experience;
  var skills;
  String? email;
  String? contact;
  String? url;

  Seekers({
    this.name,
    this.bio,
    this.experience,
    this.skills,
    this.email,
    this.contact,
    this.url,
  });

  Seekers.fromMap(DocumentSnapshot data) {
    name = data['name'];
    bio = data["bio"];
    experience = data["experience"];
    skills = data["skills"];
    email = data["email"];
    contact = data["contact"];
    url = data["url"];
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (bio != null) "bio": bio,
      if (experience != null) "experience": experience,
      if (skills != null) "skills": FieldValue.arrayUnion([skills]),
      if (email != null) "email": email,
      if (contact != null) "contact": contact,
      if (url != null) "url": url,
    };
  }
}

class Companies {
  String? name;
  String? bio;
  String? email;
  String? contact;
  String? url;
  String? specialization; // ✅ Added
  bool? category;

  Companies({
    this.name,
    this.bio,
    this.email,
    this.contact,
    this.url,
    this.specialization,
    this.category,
  });

  Companies.fromMap(DocumentSnapshot data) {
    final map = data.data() as Map<String, dynamic>;
    name = map['name'];
    bio = map['bio'];
    email = map['email'];
    contact = map['contact'];
    url = map['url'];
    specialization = map['specialization'];
    category = map['category'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'bio': bio,
      'email': email,
      'contact': contact,
      'url': url,
      'specialization': specialization,
      'category': category,
    };
  }
}
