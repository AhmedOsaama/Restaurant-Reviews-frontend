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
  bool loaded = false;
  @override
  void initState() {
    Provider.of<Restaurants>(context, listen: false)
        .getAllRestaurants().then((value) => loaded = true);
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
    // print(restaurantList.length);
    // print(loaded);
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
            restaurantList.isNotEmpty && loaded
                ? Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index){
                        return const Divider(thickness: 2.0,);
                      },
                        itemCount: restaurantList.length,
                        itemBuilder: (ctx, i) => restaurantList.isEmpty
                            ? const Text('no restaurants yet')
                            : Padding(
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
                  )
                : loaded ? const Center(child: Text("No restaurants yet!")) : const CircularProgressIndicator(),
            // }),
            if (widget.username != null)
              RaisedButton(
                color: Colors.lightBlue[300],
                textColor: Colors.white,
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => AddRestaurantScreen(widget.username))),
                child: Text(
                  "Add restaurant",
                ),
              ),
          ],
        ),
      ),
    );
  }
}
