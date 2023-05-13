import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String username;
  String email;
  String address;
  String careGiverEmail;
  User(
      {required this.username,
      required this.email,
      required this.address,
      required this.careGiverEmail});
  factory User.fromJson(Map<String, dynamic> json) => User(
      username: json['username'],
      email: json['email'],
      address: json['address'],
      careGiverEmail: json['careGiverEmail']);

  Map<String, dynamic> toJson() => {
        'username': username,
        'email': email,
        'address': address,
        'careGiverEmail': careGiverEmail
      };

  factory User.fromSnapshot(DocumentSnapshot snapshot) {
    return User(
        username: snapshot.get('username'),
        email: snapshot.get('email'),
        address: snapshot.get('address'),
        careGiverEmail: snapshot.get('careGiverEmail'));
  }
}
