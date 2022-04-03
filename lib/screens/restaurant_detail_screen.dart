// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_reviews/screens/review_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final name;
  final postcode;
  final photoUrl;
  final foodType;
  final date;
  final description;
  final username;
  final docId;
  final reviews;
  RestaurantDetailScreen(
      {Key? key,
      this.name,
      this.postcode,
      this.photoUrl,
      this.foodType,
      this.date,
      this.description,
      this.username,
      this.docId,
      this.reviews})
      : super(key: key);

  bool hasReviewed = false;
  var totalFoodScore = 0;
  var totalServiceScore = 0;
  var totalValueScore = 0;

  double averageFoodScore = 0;
  double averageServiceScore = 0;
  double averageValueScore = 0;

  @override
  Widget build(BuildContext context) {
    // print(reviews);
    if (reviews != null) {
      //reviews.values: list of all reviews for a restaurant.
      for (var review in reviews.values) {
        if (username == review['username']) {
          // print('${username} ${review['username']}');
          hasReviewed = true;
        }
        totalFoodScore += review['foodScore'] as int;
        totalServiceScore += review['serviceScore'] as int;
        totalValueScore += review['valueScore'] as int;
      }
      averageFoodScore = totalFoodScore / reviews.values.length;
      averageServiceScore = totalServiceScore / reviews.values.length;
      averageValueScore = totalValueScore / reviews.values.length;
    }
    // print(hasReviewed);
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(photoUrl),
              const SizedBox(
                height: 10,
              ),
              Text(name),
              const SizedBox(
                height: 10,
              ),
              Text(postcode),
              const SizedBox(
                height: 10,
              ),
              Text(foodType),
              const SizedBox(
                height: 10,
              ),
              Text(
                  "Created: ${DateFormat().add_yMMMd().format(date)}"),
              const SizedBox(
                height: 10,
              ),
              // MarkdownBody(data: description),
              Padding(
                padding: EdgeInsets.all(10),
                child: MarkdownBody(
                  data: description,
                  onTapLink: (text, href, title) {
                    href != null ? launch(href) : null;
                  },
                ),
              ),
              if (reviews != null) Text("food: $averageFoodScore"),
              if (reviews != null) Text("service: $averageServiceScore"),
              if (reviews != null) Text("value: $averageValueScore"),
              SizedBox(height: 10,),
              if (username != null && !hasReviewed)
                ElevatedButton(
                    onPressed: () =>
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (ctx) => ReviewScreen(
                                  username: username,
                                  docId: docId,
                                ))),
                    child: Text("Leave review"))
            ],
          ),
        ),
      ),
    );
  }
}
