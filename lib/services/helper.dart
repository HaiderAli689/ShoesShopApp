
import 'package:flutter/services.dart' as the_bundle;
import 'package:online_shop/models/sneaker_model.dart';
import 'package:online_shop/services/config.dart';
import 'package:http/http.dart' as http;

// this class fetches data from the json file and return it to the app
class Helper {
  static var client = http.Client();

  // Male
  Future<List<Sneakers>> getMaleSneakers() async {
    final data =
        await the_bundle.rootBundle.loadString("assets/json/men_shoes.json");

    final maleList = sneakersFromJson(data);

    return maleList;
  }

// Female
  Future<List<Sneakers>> getFemaleSneakers() async {
    final data =
        await the_bundle.rootBundle.loadString("assets/json/women_shoes.json");

    final femaleList = sneakersFromJson(data);

    return femaleList;
  }

// Kids
  Future<List<Sneakers>> getKidsSneakers() async {
    final data =
        await the_bundle.rootBundle.loadString("assets/json/kids_shoes.json");

    final kidsList = sneakersFromJson(data);

    return kidsList;
  }

  // Single Male
  Future<List<Sneakers>> getMaleSneakersById(String id) async {

    var url = Uri.http(Config.apiUrl,Config.sneakers);
    var response = await client.get(url);

    if(response.statusCode==200){
      final maleList = sneakersFromJson(response.body);
      var male = maleList.where((element) => element.category == "Man's Running");
      return male.toList();
    }else{
      throw Exception("Failed get Sneakers List");
    }

  }

    // Single FeMale
  Future<List<Sneakers>> getFemaleSneakersById(String id) async {

    var url = Uri.http(Config.apiUrl,Config.sneakers);
    var response = await client.get(url);

    if(response.statusCode==200){
      final femaleList = sneakersFromJson(response.body);
      var female = femaleList.where((element) => element.category == "Woman's Running");
      return female.toList();
    }else{
      throw Exception("Failed get Sneakers List");
    }


  }


    // Single Kids
  Future<List<Sneakers>> getKidsSneakersById(String id) async {

    var url = Uri.http(Config.apiUrl,Config.sneakers);
    var response = await client.get(url);


    if(response.statusCode==200){
      final kidsList = sneakersFromJson(response.body);
      var kids = kidsList.where((element) => element.category == "Kid's Running");
      return kids.toList();
    }else{
      throw Exception("Failed get Sneakers List");
    }

  }

  Future<List<Sneakers>> search(String searchQuery) async {
    
    var url = Uri.http(Config.apiUrl,"${Config.search}$searchQuery");

    var response = await client.get(url);

    if(response.statusCode==200){
      final result = sneakersFromJson(response.body);

      return result;
    }else{
      throw Exception("Failed get Sneakers List");
    }
  }
}
