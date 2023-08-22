import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hive/hive.dart';
import 'package:online_shop/controllers/cart_provider.dart';
import 'package:online_shop/views/shared/appstyle.dart';
import 'package:online_shop/views/shared/checkout_btn.dart';
import 'package:online_shop/views/shared/reuseable_text.dart';
import 'package:online_shop/views/ui/homepage.dart';
import 'package:online_shop/views/ui/mainscreen.dart';
import 'package:provider/provider.dart';

import '../../cart/get_products.dart';
import '../../services/cart_helper.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final _cartBox = Hive.box('cart_box');
  List<dynamic> cart =[];

  late Future<List<Product>> _cartList;

  @override
  void initState() {
    // TODO: implement initState
    _cartList = CartHelper().getCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getCart();
    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),


                Text("My Cart",
                  style:appstyle(40, Colors.black, FontWeight.bold) ,),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.65,
                  child: FutureBuilder(
                    future: _cartList,
                    builder: (context, snapshot) {
                    /*  if(snapshot.connectionState == ConnectionState.waiting){
                        return Center(child: CircularProgressIndicator.adaptive());
                      }else if(snapshot.hasError){
                        return Center(
                          child: reusableText(text: "Failed to get cart data!", 
                              style: appstyle(18, Colors.black, FontWeight.w600)),
                        );
                      }
                      else{
                        final cartData = snapshot.data;*/
                        return ListView.builder(
                            itemCount: cartProvider.cart.length,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              final data = cartProvider.cart[index];
                              return GestureDetector(
                                onTap: (){
                                  //CartProvider.setProductIndex = index;
                                  //CartProvider.checkout.insert(0, data);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: ClipRRect(
                                    borderRadius:
                                    const BorderRadius.all(Radius.circular(12)),
                                    child: Slidable(
                                      key: const ValueKey(0),
                                      endActionPane: ActionPane(
                                        motion: const ScrollMotion(),
                                        children: [
                                          SlidableAction(
                                            flex: 1,
                                            onPressed: doNothing,
                                            backgroundColor: const Color(0xFF000000),
                                            foregroundColor: Colors.white,
                                            icon: Icons.delete,
                                            label: 'Delete',
                                          ),
                                        ],
                                      ),
                                      child: Container(
                                        height:
                                        MediaQuery.of(context).size.height * 0.11,
                                        width: MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade100,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey.shade500,
                                                  spreadRadius: 5,
                                                  blurRadius: 0.3,
                                                  offset: const Offset(0, 1)),
                                            ]),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Stack(
                                              clipBehavior: Clip.none,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(12),
                                                  child: CachedNetworkImage(
                                                    imageUrl: data['imageUrl'],
                                                    width: 70,
                                                    height: 70,
                                                    fit: BoxFit.fill,
                                                  ),

                                                ),
                                                Positioned(
                                                    top: -4,
                                                    child: GestureDetector(
                                                      onTap: () //async
                                                      {

                                                      },
                                                      child: SizedBox(
                                                        width: 30.w,
                                                        height: 30.h,
                                                        child: Icon(  // CartProvider.productIndex == index
                                                          Feather.check_square,
                                                          size: 20,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    )),
                                                Positioned(
                                                    bottom: -2,
                                                    child: GestureDetector(
                                                      onTap: () //async
                                                      {
                                                        /*await CartHelper().deleteItem(data.id).then((response){
                                                          if(response == true){
                                                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> MainScreen()));
                                                          }else{
                                                            debugPrint("Failed to delete the item");
                                                          }
                                                        });*/
                                                        cartProvider.deletecart(data['key']);
                                                        Navigator.push(context, MaterialPageRoute(builder: (context)=> MainScreen()));
                                                      },
                                                      child: Container(
                                                        height: 30,
                                                        width: 40,
                                                        decoration: BoxDecoration(
                                                            color: Colors.black,
                                                            borderRadius: BorderRadius.only(
                                                              topRight: Radius.circular(12),
                                                              bottomLeft: Radius.circular(12),

                                                            )
                                                        ),
                                                        child: Icon(AntDesign.delete,
                                                          size: 20,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    )),
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      top: 12, left: 100),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        data['name'],
                                                        style: appstyle(
                                                            16,
                                                            Colors.black,
                                                            FontWeight.bold),
                                                      ),
                                                      Text(
                                                        data['category'],
                                                        style: appstyle(12, Colors.grey,
                                                            FontWeight.w600),
                                                      ),

                                                      Row(
                                                        children: [
                                                          Text(
                                                            data['price'],
                                                            style: appstyle(
                                                                16,
                                                                Colors.black,
                                                                FontWeight.w600),
                                                          ),
                                                          const SizedBox(
                                                            width: 40,
                                                          ),
                                                          Text(
                                                            "Size",
                                                            style: appstyle(
                                                                18,
                                                                Colors.grey,
                                                                FontWeight.w600),
                                                          ),
                                                          const SizedBox(
                                                            width: 15,
                                                          ),
                                                          Text(
                                                            data['sizes'],
                                                            style: appstyle(
                                                                18,
                                                                Colors.grey,
                                                                FontWeight.w600),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    decoration: const BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.all(
                                                            Radius.circular(16))),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        InkWell(
                                                            onTap: () {
                                                              cartProvider.increment();
                                                            },
                                                            child: const Icon(
                                                              AntDesign.minussquare,
                                                              size: 20,
                                                              color: Colors.grey,
                                                            )),
                                                        Text(
                                                          data['qty'].toString(),
                                                          style: appstyle(
                                                            16,
                                                            Colors.black,
                                                            FontWeight.w600,
                                                          ),
                                                        ),
                                                        InkWell(
                                                            onTap: () {
                                                              cartProvider.decrement();
                                                            },
                                                            child: const Icon(
                                                              AntDesign.plussquare,
                                                              size: 20,
                                                              color: Colors.black,
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                ),

                                                // ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
                      }

                    //}
                  ),
                )
              ],
            ),
            const Align(alignment: Alignment.bottomCenter,
              child: CheckoutButton(label: "Proceed to Checkout"),),
          ],
        ),
      ),
    );
  }

  void doNothing(BuildContext context) {}
}
