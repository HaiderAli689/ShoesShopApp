
import 'dart:convert';

ProfileRes profileResModelFromJson(String str) => ProfileRes.fromJson(json.decode(str));

String profileResToJson(ProfileRes data) => json.encode(data.toJson());

class ProfileRes{

  final String userName;
  final String id;
  final String email;
  final String location;

  ProfileRes({
    required this.userName,
    required this.id,
    required this.email,
    required this.location,
  });

  factory ProfileRes.fromJson(Map<String, dynamic> json) => ProfileRes(
      id: json['_id'],
      userName: json['userName'],
      email: json['email'],
      location: json['location']);

   Map<String, dynamic> toJson() =>{
     "_id":id,
     "_userName":userName,
     "_email":email,
     "_location":location
   };
}