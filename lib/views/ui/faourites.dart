import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hive/hive.dart';
import 'package:online_shop/controllers/favorites_provider.dart';
import 'package:online_shop/controllers/login_provider.dart';
import 'package:online_shop/views/shared/appstyle.dart';
import 'package:online_shop/views/ui/mainscreen.dart';
import 'package:provider/provider.dart';

import '../../models/constants.dart';
import 'nonuser.dart';

class Favorites extends StatefulWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    var favoriteNotifier = Provider.of<FavoritesNotifier>(context, listen: true);
    var authNotifier = Provider.of<LoginNotifier>(context);
    favoriteNotifier.getAllData();
    return /*authNotifier.login == false ? NonUser() : */Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 45, 0, 0),
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/top_image.png"),
                      fit: BoxFit.fill)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "My Favorites",
                  style: appstyle(36, Colors.white, FontWeight.bold),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(8)),
            ListView.builder(
                padding: EdgeInsets.only(top: 100),
                itemCount: favoriteNotifier.fav.length,
                itemBuilder: (BuildContext context, int index) {
                  final shoe = favoriteNotifier.fav[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.11,
                        width: MediaQuery.of(context).size.width * 0.11,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade500,
                              spreadRadius: 5,
                              blurRadius: 0.3,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(12),
                                  child: CachedNetworkImage(
                                    imageUrl: shoe['imageUrl'],
                                    width: 70,
                                    height: 70,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 20, top: 12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        shoe['name'],
                                        style: appstyle(
                                            14, Colors.black, FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        shoe['category'],
                                        style: appstyle(
                                            12, Colors.grey, FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            shoe['price'],
                                            style: appstyle(15, Colors.black,
                                                FontWeight.bold),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  favoriteNotifier.deleteFav(shoe['key']);
                                  favoriteNotifier.ids.removeWhere(
                                      (element) => element == shoe['id']);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MainScreen()));
                                },
                                child: Icon(Ionicons.heart),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
