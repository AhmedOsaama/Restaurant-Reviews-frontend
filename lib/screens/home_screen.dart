import 'package:flutter/material.dart';
import 'package:restaurant_reviews/screens/add_restaurant_screen.dart';

class HomeScreen extends StatelessWidget {
  final username;
  HomeScreen({Key? key, this.username}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Restaurants'),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(textColor: Colors.white,color: Theme.of(context).accentColor,onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => AddRestaurantScreen(username))) ,child: Text("Add restaurant"),),
          ],
        ),
      ),
    );
  }
}
