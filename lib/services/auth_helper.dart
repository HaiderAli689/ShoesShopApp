
import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:online_shop/auth_response/profilr_res.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../auth/login_model.dart';
import '../auth/signup_model.dart';
import '../auth_response/auth_response.dart';
import 'config.dart';

class AuthHelper{

  static var client =  http.Client();

  Future<bool> login(LoginModel model) async {

    Map<String, String> requestHeaders ={
      'content-type': 'application/json'
    };
    var url = Uri.http(Config.apiUrl,Config.loginUrl);
    var response = await client.post(url, headers: requestHeaders,body: jsonEncode(model.toJson()));

    if(response.statusCode==200){
      print(response.statusCode);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String userToken = loginResponseModelFromJson(response.body).token;
      String userId = loginResponseModelFromJson(response.body).id;

      await prefs .setString('token', userToken);
      await prefs .setString('userId', userId);
      await prefs.setBool('isLoading', true);

      return true;
    }else{
      return false;

    }

  }

  Future<bool> signup(SignupModel model) async {

    Map<String, String> requestHeaders ={
      'content-type': 'application/json'
    };
    var url = Uri.http(Config.apiUrl,Config.signupUrl);
    var response = await client.post(url, headers: requestHeaders,body: jsonEncode(model.toJson()));

    if(response.statusCode==201){


      return true;
    }else{
      return false;
    }


  }
  Future<ProfileRes> getProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('token');
    Map<String, String> requestHeaders ={
      'content-type': 'application/json',
      'token': 'Bearer $userToken'
    };
    var url = Uri.http(Config.apiUrl,Config.getUserUrl);
    var response = await client.get(url, headers: requestHeaders,);

    if(response.statusCode==200){
      var profile = profileResModelFromJson(response.body);
      return profile;
    }else{
      throw Exception("Failed get Sneakers List");
    }


  }
}

