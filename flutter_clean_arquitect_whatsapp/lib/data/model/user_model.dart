
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_clean_arquitect_whatsapp/domain/entities/user_entity.dart';

class UserModel extends UserEntity {

  UserModel({
    required String name,
    required String email,
    required String phoneNumber,
    required bool isOnline,
    required String uid,
    required String status,
    required String profileUrl,
  }) : super(
    name: name,
    email: email,
    phoneNumber: phoneNumber,
    isOnline: isOnline,
    uid: uid,
    status: status,
    profileUrl: profileUrl,
  );

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    return UserModel(
      name: snapshot.data()['name'],
      email: snapshot.data()['email'],
      phoneNumber: snapshot.data()['phoneNumber'],
      uid: snapshot.data()['uid'],
      isOnline: snapshot.data()['isOnline'],
      profileUrl: snapshot.data()['profileUrl'],
      status: snapshot.data()['status'],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "name": name,
      "email": email,
      "phoneNumber": phoneNumber,
      "uid": uid,
      "isOnline": isOnline,
      "profileUrl": profileUrl,
      "status": status,
    };
  }
}