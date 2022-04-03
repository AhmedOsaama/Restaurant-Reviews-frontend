import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_reviews/providers/restaurant.dart';
import 'package:restaurant_reviews/screens/add_restaurant_screen.dart';
import 'package:restaurant_reviews/screens/login_screen.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_reviews/widgets/restaurant_widget.dart';

class HomeScreen extends StatefulWidget {
  final username;
  HomeScreen({Key? key, this.username}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<Restaurants>(context,listen: false).getAllRestaurants();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final restaurantProvider = Provider.of<Restaurants>(context);
    // restaurantProvider.getAllRestaurants();
    final restaurantList = restaurantProvider.restaurants;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurants'),
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => LoginScreen())),
              icon: const Icon(Icons.login))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // FutureBuilder(
            //     future: restaurantsFuture,
            //     builder: (ctx, snapshot) {
            //       if (snapshot.connectionState == ConnectionState.waiting) {
            //         return Center(child: CircularProgressIndicator());
            //       }
            //       return
                    Expanded(
                    child: ListView.builder(
                        itemCount: restaurantList.length,
                        itemBuilder: (ctx, i) => restaurantList.isEmpty ? const Text('no restaurants yet') : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RestaurantWidget(
                            username: widget.username,
                            docId: restaurantList[i].docId,
                            postcode: restaurantList[i].postcode,
                                name: restaurantList[i].name,
                                imageSrc: restaurantList[i].photoUrl,
                            description: restaurantList[i].description,
                            date: restaurantList[i].dateTime,
                            foodType: restaurantList[i].foodType,
                            reviews: restaurantList[i].reviews,
                              ),
                        )),
                  ),
                // }),
            if(widget.username != null)
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => AddRestaurantScreen(widget.username))),
              child: Text("Add restaurant"),
            ),
          ],
        ),
      ),
    );
  }
}
