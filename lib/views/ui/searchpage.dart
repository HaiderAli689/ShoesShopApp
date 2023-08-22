

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:online_shop/controllers/product_provider.dart';
import 'package:online_shop/models/sneaker_model.dart';
import 'package:online_shop/services/helper.dart';
import 'package:online_shop/views/shared/appstyle.dart';
import 'package:online_shop/views/shared/custom_field.dart';
import 'package:online_shop/views/ui/product_page.dart';
import 'package:provider/provider.dart';

import '../shared/reuseable_text.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductNotifier>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 100.h,
        backgroundColor: Colors.black,
        elevation: 0,
        title: CustomField(
            controller:search,
            onEditingComplete: (){
          setState(() {
          });
            },
            suffixIcon:GestureDetector(
              onTap: (){

              },
              child: Icon(AntDesign.search1,color: Colors.black,),
            ) ,
            prefixIcon: GestureDetector(
              onTap: (){

              },
              child: Icon(AntDesign.camera,color: Colors.black,),
            ),
            hintText: "Search your items"),
      ),
      body:search.text.isEmpty? Container(
        height: 600.h,
        margin: EdgeInsets.only(right: 50.w),
        padding: EdgeInsets.all(20.h),
        child: Center(child: Image.asset("assets/images/empty.jpg")),
      ) : FutureBuilder<List<Sneakers>>(
        future: Helper().search(search.text),
          builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
                child: CircularProgressIndicator.adaptive());
          }else if(snapshot.hasError){
            return Center(
              child: reusableText(text: "Error retrieving the code",
              style: appstyle(20, Colors.black, FontWeight.bold),),
            );
          }else if(snapshot.data!.isEmpty){
            return Center(
              child: reusableText(text: "Product not found",
                style: appstyle(20, Colors.black, FontWeight.bold),),
            );
          }
          else{
            final shoes  = snapshot.data;
            return ListView.builder(
              itemCount: shoes!.length ,
                itemBuilder: (context, index){
                  final shoe = shoes[index];

                  return GestureDetector(

                    onTap: (){
                      productProvider.shoesSizes = shoe.sizes;
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPage(sneakers: shoe, )));
                    },
                    child: Padding(padding: EdgeInsets.all(8.h),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        height: 100.h,
                        width: 325,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade500,
                              spreadRadius: 5,
                              blurRadius: 0.3,
                              offset: Offset(0,1)
                            )
                          ]
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                         Padding(padding: EdgeInsets.all(12.h),
                           child: CachedNetworkImage(
                             imageUrl: shoe.imageUrl[0],
                             height: 70.h,
                             width: 70.w,
                             fit: BoxFit.cover,
                           ),
                         ),
                           Padding(padding: EdgeInsets.only(left:12.h ,top:20.w ),
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 reusableText(text: shoe.name,
                                 style: appstyle(16, Colors.black, FontWeight.w600)),
                                 SizedBox(height: 5,),
                                 reusableText(text: shoe.category,
                                     style: appstyle(13 , Colors.black, FontWeight.w600)), SizedBox(height: 5,),
                                 reusableText(text: shoe.price,
                                     style: appstyle(13 , Colors.black, FontWeight.w600)),
                               ],
                             ),
                           )
                        ],
                        ),
                      ),
                    ),),
                  );

                });
          }
          }
          )
    );
  }
}