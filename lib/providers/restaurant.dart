import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Restaurant {
  final String docId;
  final String name;
  final String postcode;
  final String photoUrl;
  final String foodType;
  final DateTime dateTime;
  final String description;
  final reviews;

  Restaurant(
      {required this.docId,
      required this.name,
      required this.postcode,
      required this.photoUrl,
      required this.foodType,
      required this.dateTime,
      required this.description,
      required this.reviews});
}

class Restaurants with ChangeNotifier {
  final List<Restaurant> _restaurants = [];
  // final List<Restaurant> _reviews = [];

  List<Restaurant> get restaurants {
    return [..._restaurants];
  }


  Future<void> addRestaurant({
      required String username,
      required String restaurantName,
      required String postcode,
      required String foodType,
      required String description,
      required DateTime dateTime,
      required String photoUrl}) async {
    // print(username);
    // final newRestaurant = Restaurant(docId: docId, name: name, postcode: postcode, photoUrl: photoUrl, foodType: foodType, dateTime: dateTime, description: description, reviews: reviews)
    // final url = Uri.parse("http://10.0.2.2:5000/restaurant/add");
    final url = Uri.parse("https://all-restaurant-reviews.herokuapp.com/restaurant/add");
    final response = await http.post(
      url,
      body: jsonEncode({
        'username': username,
        'name': restaurantName,
        'postcode': postcode,
        'foodType': foodType,
        'description': description,
        'dateTime': dateTime.toIso8601String(),
        'photoUrl': photoUrl
      }),
    );
    final decodedResponse = jsonDecode(response.body);
    // if (response.statusCode == 200) {
    //   getAllRestaurants();
    // }
    getAllRestaurants();
    // print(decodedResponse);
  }

  Future<dynamic> getAllRestaurants() async {
    try {
      // var url = Uri.parse("http://10.0.2.2:5000/restaurant/all");
      var url = Uri.parse("https://all-restaurant-reviews.herokuapp.com/restaurant/all");
      final response = await http.get(url);
      final Map<String, dynamic> decodedResponse = jsonDecode(response.body);
      // print(decodedResponse);
      if (_restaurants.isNotEmpty) {
        _restaurants.clear();
      }
      for (var restaurant in decodedResponse.values) {
        _restaurants.add(Restaurant(
          docId: restaurant['docId'],
          postcode: restaurant['postcode'],
          name: restaurant['name'],
          photoUrl: restaurant['photoUrl'],
          description: restaurant['description'],
          dateTime: DateTime.parse(restaurant['dateTime']),
          foodType: restaurant['foodType'],
          reviews: restaurant['reviews'],
        ));
      }
    }catch(error){
      print(error);
    }
    notifyListeners();
    // print(_restaurants.length);
  }
}
