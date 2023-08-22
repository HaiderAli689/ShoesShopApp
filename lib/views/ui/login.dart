
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shop/auth/login_model.dart';
import 'package:online_shop/controllers/login_provider.dart';
import 'package:online_shop/views/shared/appstyle.dart';
import 'package:online_shop/views/shared/custom_field.dart';
import 'package:online_shop/views/shared/reuseable_text.dart';
import 'package:online_shop/views/ui/mainscreen.dart';
import 'package:online_shop/views/ui/register.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool validation = false;
  void formValidation(){
    if(email.text.isNotEmpty && password.text.isNotEmpty){
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

            reusableText(text: "Fill in details to your login into your account",
                style: appstyle(14, Colors.grey, FontWeight.normal)),

            SizedBox(height: 50.h,),
            CustomField(
              keyboard: TextInputType.emailAddress,
                controller: email,
                hintText: 'Email',
            validator: (email){
                if(email!.isEmpty && !email.contains("0")){
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
                },
                child: reusableText(
                    text: "Don't have an account? SignUp",
                    style: appstyle(12, Colors.grey, FontWeight.normal)),
              ),
            ),
            SizedBox(height: 40.h,),
            GestureDetector(
              onTap: (){
                formValidation();
                if(validation ==true){
                  LoginModel model = 
                      LoginModel(
                          email: email.text,
                          password: password.text);
                  authNotifier.userLogin(model).then((response) {
                    if(response == true){
                      debugPrint("Successfully login");

                      Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
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
                    child: reusableText(text: "L O G I N", style: appstyle(18, Colors.black, FontWeight.bold))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
