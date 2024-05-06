import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  final String? id;
  final String? username;
  final String? email;

  UserModel({this.id,this.username,this.email});

  static UserModel fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return UserModel(
      username: snapshot.data()!['username'],
      email: snapshot.data()!['email'],
      id: snapshot.data()!['id'],
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "username" : username,
      "email" : email,
      "id" : id,
    };
  }
}