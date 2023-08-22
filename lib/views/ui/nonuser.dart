

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:online_shop/views/shared/appstyle.dart';
import 'package:online_shop/views/shared/reuseable_text.dart';

import 'login.dart';

class NonUser extends StatelessWidget {
  const NonUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffe2e2e2),
        elevation: 0,
        leading: Icon(MaterialCommunityIcons.qrcode,
        size: 18,
        color: Colors.black,),
        actions: [
          GestureDetector(
            onTap: (){},
            child: Padding(padding: EdgeInsets.only(right: 16),
            child: Row(
              children: [
                //SvgPicture.asset('assets/images/usa.svg',width: 15.w, height: 25,)
                Icon(Icons.language,color: Colors.black,),
                SizedBox(width: 5.w,),
                Container(
                  height: 15.h,
                  width: 1.w,
                  color: Colors.grey,
                ),
                reusableText(text: "  Country",
                    style: appstyle(14, Colors.black, FontWeight.normal)),
                SizedBox(width: 10.w,),

                Padding(padding: EdgeInsets.only(bottom: 4),
                child: Icon(SimpleLineIcons.settings,size: 18,color: Colors.black,),)
              ],
            ),),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 740.h,
            decoration: BoxDecoration(
              color: Color(0xffe2e2e2),
            ),child: Column(
              children: [
                Padding(padding: EdgeInsets.fromLTRB(12, 10, 16, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [

                        SizedBox(height: 35.h,width: 35.w,
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/images/user.jpg'),
                        ),),
                        SizedBox(width: 8,),
                        reusableText(text: "Please login your into your account",
                            style: appstyle(12, Colors.grey.shade600, FontWeight.normal)),
                      ],
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 5),
                        height: 30.h,
                        width: 50.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black
                        ),
                        child: Center(
                          child: reusableText(text: "Login",
                              style: appstyle(12, Colors.white, FontWeight.normal)),
                        ),
                      ),
                    )

                  ],
                ),)
              ],
            ),)
          ],
        ),
      ),
    );
  }
}
