

import 'package:flutter/cupertino.dart';
import 'package:online_shop/services/auth_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth/login_model.dart';
import '../auth/signup_model.dart';
import '../services/config.dart';

class LoginNotifier with ChangeNotifier{

  bool _isObscure = false;
  bool get isObscure => _isObscure;

  LoginModel? get model => null;
  set isObscure(bool newState){
    _isObscure = newState;
    notifyListeners();
  }

  bool _processing = false;
  bool get processing => _processing;
  set processing(bool newState){
    _processing = newState;
    notifyListeners();
  }

  bool _loginResBool = false;
  bool get loginResBool => _loginResBool;
  set loginResBool(bool newState){
    _loginResBool = newState;
    notifyListeners();
  }

  bool _responseBool = false;
  bool get responseBool => _responseBool;
  set responseBool(bool newState){
    _responseBool = newState;
    notifyListeners();
  }

  bool? _login;
  bool get login => _login ?? false;
  set login(bool newState){
    _login = newState;
    notifyListeners();
  }

  Future<bool> userLogin(LoginModel model) async{

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    processing = true;
     bool response = await AuthHelper().login(model);
    processing = false;

    loginResBool = response;

    login = prefs.getBool('isLogged') ?? false;
    return loginResBool;
  }


  logout()async{

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove('token');
    prefs.remove('userId');
    prefs.setBool('isLogged', false);
    login = prefs.getBool('isLogged') ?? false;
  }

  Future<bool> registerUser(SignupModel model) async{
    responseBool = await AuthHelper().signup(model);

    return responseBool;

  }

  getPrefs() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    login = prefs.getBool('isLogged') ?? false;
  }

}