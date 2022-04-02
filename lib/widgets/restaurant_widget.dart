import 'package:flutter/material.dart';
import 'package:restaurant_reviews/screens/restaurant_detail_screen.dart';

class RestaurantWidget extends StatelessWidget {
  final imageSrc;
  final name;
  final postcode;
  final foodType;
  final date;
  final description;
  final username;
  final docId;
  final reviews;
  RestaurantWidget(
      {Key? key,
      this.postcode,
      this.imageSrc,
      this.name,
      this.foodType,
      this.date,
      this.description, this.username, this.docId, this.reviews})
      : super(key: key);

  var totalFoodScore = 0;
  var totalServiceScore = 0;
  var totalValueScore = 0;

  var averageScore = 0.0;

  @override
  Widget build(BuildContext context) {
    if(reviews != null) {
      for (var review in reviews.values) {
        totalFoodScore += review['foodScore'] as int;
        totalServiceScore += review['serviceScore'] as int;
        totalValueScore += review['valueScore'] as int;
      }
      print(totalValueScore);
      print(totalFoodScore);
      print(totalServiceScore);
    averageScore = (totalServiceScore + totalFoodScore + totalValueScore) / reviews.values.length;
    }
    return Column(
      children: [
        Container(width: 300, child: Image.network(imageSrc)),
        const SizedBox(
          height: 10,
        ),
        Text(name),
        const SizedBox(
          height: 10,
        ),
        Text(postcode),
        if(reviews != null) SizedBox(height: 10,),
        if(reviews != null) Text("$averageScore"),
        ElevatedButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => RestaurantDetailScreen(
                  docId: docId,
                  username: username,
                      name: name,
                      postcode: postcode,
                      photoUrl: imageSrc,
                      foodType: foodType,
                      description: description,
                      date: date,
                  reviews: reviews,
                    ))),
            child: const Text("Details"))
      ],
    );
  }
}
