
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shop/auth/signup_model.dart';
import 'package:online_shop/views/ui/login.dart';
import 'package:provider/provider.dart';

import '../../controllers/login_provider.dart';
import '../shared/appstyle.dart';
import '../shared/custom_field.dart';
import '../shared/reuseable_text.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();

  bool validation = false;
  void formValidation(){
    if(email.text.isNotEmpty && password.text.isNotEmpty && username.text.isNotEmpty){
      validation=true;
    }else{

    }
  }

  @override
  Widget build(BuildContext context) {

    var authNotifier = Provider.of<LoginNotifier>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 50.h,
        backgroundColor: Colors.black,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: BoxDecoration(
            image: DecorationImage(
                opacity: 0.5,
                image: AssetImage('assets/images/bg.jpg',),fit: BoxFit.cover)
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            reusableText(
                text: "Welcome",
                style: appstyle(30, Colors.white, FontWeight.w600)),

            reusableText(text: "Fill in details to your Signup into your account",
                style: appstyle(14, Colors.grey, FontWeight.normal)),

            SizedBox(height: 50.h,),
            CustomField(
              keyboard: TextInputType.name,
              controller: username,
              hintText: 'Username',
              validator: (username){
                if(username!.isEmpty ){
                  return "Please provide Username";
                }else{
                  return null;
                }
              },),
            SizedBox(height: 15.h,),
            CustomField(
              keyboard: TextInputType.emailAddress,
              controller: email,
              hintText: 'Email',
              validator: (email){
                if(email!.isEmpty && !email.contains("@")){
                  return "Please provide valid email";
                }else{
                  return null;
                }
              },),
            SizedBox(height: 16.h,),
            CustomField(
              controller: password,
              keyboard: TextInputType.visiblePassword,
              suffixIcon: GestureDetector(
                onTap: (){
                  authNotifier.isObscure = !authNotifier.isObscure;
                },
                child:authNotifier.isObscure? Icon(Icons.visibility_off):Icon(Icons.visibility) ,
              ),
              hintText: 'Password',
              obscureText: authNotifier.isObscure,
              validator: (password){
                if(password!.isEmpty && password.length<7){
                  return "Password too weak";
                }else{
                  return null;
                }
              },),

            SizedBox(height: 10.h,),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: reusableText(
                    text: "Already have an account? Login",
                    style: appstyle(12, Colors.grey, FontWeight.normal)),
              ),
            ),
            SizedBox(height: 40.h,),
            GestureDetector(
              onTap: (){
                formValidation();
                if(validation ==true){
                  SignupModel model =
                  SignupModel(
                      email: email.text,
                      password: password.text,
                      username: username.text);
                  authNotifier.registerUser(model).then((response) {
                    if(response == true){
                      print("Successfully registered!");
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                    }else{
                      debugPrint("Failed to login");
                    }
                  });
                }else{
                  debugPrint("Form not validated");
                }
              },
              child: Container(
                height: 55.h,
                width: 300,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)
                ),
                child: Center(
                    child: reusableText(text: "S I G N U P", style: appstyle(18, Colors.black, FontWeight.bold))),
              ),
            )
          ],
        ),
      ),
    );
  }

}
