
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';


class FavoritesNotifier with ChangeNotifier{
  List<dynamic> _ids =[];


  List<dynamic> get ids => _ids;

  set ids(List<dynamic> newIds){
    _ids = newIds;
    notifyListeners();
  }
  List<dynamic>  _favorites = [];

  List<dynamic> get favorites => _favorites;

  set favorites(List<dynamic> newfav){
    _favorites = newfav;
    notifyListeners();
  }

  final _favBox = Hive.box('fav_box');
  Future<void>  createFav(Map<String, dynamic> addFav)async {
    await _favBox.add(addFav);

  }


  getFavItems(){
    final favData = _favBox.keys.map((key){
      final items = _favBox.get(key);
      return {
        "key": key,
        "id": items["id"]
      };
    }).toList();

    _favorites = favData.toList();
    _ids = _favorites.map((item) => item['id']).toList();

  }
  List<dynamic> _fav = [];
  List<dynamic>  get fav => _fav;

  set fav(List<dynamic> newfav){
    _fav = newfav;
    notifyListeners();
  }

  getAllData(){
    final favData = _favBox.keys.map((key){
      final items = _favBox.get(key);
      return {
        "key": key,
        "id": items["id"],
        "name": items["name"],
        "category": items["category"],
        "price": items["price"],
        "imageUrl": items["imageUrl"]
      };
    }).toList();
    _fav = favData.reversed.toList();
  }

  Future<void >deleteFav(int key)async {
    await _favBox.delete(key);
  }
}