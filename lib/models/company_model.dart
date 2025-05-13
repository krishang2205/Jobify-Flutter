import 'package:cloud_firestore/cloud_firestore.dart';

class Company {
  final String name;
  final String specialization;
  final String experience;
  final String bio;
  final String? url; // Add 'url' field
  final String email; // Add 'email' field

  Company({
    required this.name,
    required this.specialization,
    required this.experience,
    this.bio = '', // Default empty bio
     this.url,  // Make it optional
    required this.email,
  });

  factory Company.fromMap(Map<String, dynamic> data) {
    return Company(
      name: data['name'] ?? '',
      specialization: data['specialization'] ?? '',
      experience: data['experience']?.toString() ?? '0',
      bio: data['bio'] ?? '',
      url: data['url'], // Ensure it's properly fetched from Firestore
      email: data['email'] ?? '',
    );
  }

  factory Company.fromDocument(DocumentSnapshot doc) {
    return Company.fromMap(doc.data() as Map<String, dynamic>);
  }
}

class CompanyList {
  final String name;
  final String? bio;
  final String specialization;
  final String? email;
  final String? contact;
  final String? url;
  final String? category;

  CompanyList({
    required this.name,
    this.bio,
    required this.specialization,
    this.email,
    this.contact,
    this.url,
    this.category,
  });

  factory CompanyList.fromJson(Map<String, dynamic> data) {
    return CompanyList(
      name: data['name'] ?? '',
      bio: data['bio'],
      specialization: data['specialization'] ?? '',
      email: data['email'],
      contact: data['contact'],
      url: data['url'],
      category: data['category'],
    );
  }
}
