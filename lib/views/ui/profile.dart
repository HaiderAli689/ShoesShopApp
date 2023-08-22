import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:online_shop/controllers/login_provider.dart';
import 'package:online_shop/services/auth_helper.dart';
import 'package:online_shop/views/shared/appstyle.dart';
import 'package:online_shop/views/ui/cartpage.dart';
import 'package:online_shop/views/ui/faourites.dart';
import 'package:online_shop/views/ui/nonuser.dart';
import 'package:provider/provider.dart';

import '../shared/reuseable_text.dart';
import '../shared/tilesbox.dart';
import 'login.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var authNotifier = Provider.of<LoginNotifier>(context);
    return /*authNotifier.login == false ? NonUser() :*/ Scaffold(
      backgroundColor: Color(0xffe2e2e2),
      appBar: AppBar(
        backgroundColor: Color(0xffe2e2e2),
        elevation: 0,
        leading: Icon(
          MaterialCommunityIcons.qrcode,
          size: 18,
          color: Colors.black,
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.only(right: 16),
              child: Row(
                children: [
                  //SvgPicture.asset('assets/images/usa.svg',width: 15.w, height: 25,)
                  Icon(
                    Icons.language,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Container(
                    height: 15.h,
                    width: 1.w,
                    color: Colors.grey,
                  ),
                  reusableText(
                      text: "  Country",
                      style: appstyle(14, Colors.black, FontWeight.normal)),
                  SizedBox(
                    width: 10.w,
                  ),

                  Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Icon(
                      SimpleLineIcons.settings,
                      size: 18,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 70.h,
              decoration: BoxDecoration(
                color: Color(0xffe2e2e2),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(12, 10, 16, 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: 35.h,
                              width: 35.w,
                              child: CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/user.jpg'),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            FutureBuilder(
                                future: AuthHelper().getProfile(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                        child: CircularProgressIndicator.adaptive()
                                    );
                                  } else if (snapshot.hasError) {
                                    return reusableText(
                                        text: "Error get you data",
                                        style: appstyle(
                                            18, Colors.black, FontWeight.w600));
                                  } else {
                                    final userData = snapshot.data;
                                    return SizedBox(
                                      height: 35.h,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          reusableText(
                                              text: userData?.userName ?? " ",
                                              style: appstyle(
                                                  12,
                                                  Colors.grey.shade600,
                                                  FontWeight.normal)),
                                          reusableText(
                                              text: userData?.email ?? " ",

                                              style: appstyle(
                                                  12,
                                                  Colors.grey.shade600,
                                                  FontWeight.normal)),
                                        ],
                                      ),
                                    );
                                  }
                                }),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                              onTap: () {},
                              child: Icon(Feather.edit, size: 18)),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  height: 160.h,
                  color: Colors.grey.shade200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TilesWidget(
                        title: "My Order",
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                        leading: MaterialCommunityIcons.truck_fast_outline,
                      ),
                      TilesWidget(
                        title: "My favorites",
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Favorites()));
                        },
                        leading: MaterialCommunityIcons.heart_outline,
                      ),
                      TilesWidget(
                        title: "My cart",
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CartPage()));
                        },
                        leading: MaterialCommunityIcons.cart,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 110.h,
                  color: Colors.grey.shade200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TilesWidget(
                        title: "Coupons",
                        onTap: () {},
                        leading: MaterialCommunityIcons.tag_outline,
                      ),
                      TilesWidget(
                        title: "My Store",
                        onTap: () {},
                        leading: MaterialCommunityIcons.shopping_outline,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 160.h,
                  color: Colors.grey.shade200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TilesWidget(
                        title: "Shipping Address",
                        onTap: () {},
                        leading: SimpleLineIcons.location_pin,
                      ),
                      TilesWidget(
                        title: "Settings",
                        onTap: () {},
                        leading: AntDesign.setting,
                      ),
                      TilesWidget(
                        title: "Logout",
                        onTap: () {
                          authNotifier.logout();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                        leading: MaterialCommunityIcons.logout,
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
    ;
  }
}
