import 'package:flutter/material.dart';
import 'package:restaurant_reviews/screens/restaurant_detail_screen.dart';

class RestaurantWidget extends StatelessWidget {
  final imageSrc;
  final name;
  final postcode;
  final foodType;
  final date;
  final description;
  RestaurantWidget(
      {Key? key,
      this.postcode,
      this.imageSrc,
      this.name,
      this.foodType,
      this.date,
      this.description})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
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
        ElevatedButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => RestaurantDetailScreen(
                      name: name,
                      postcode: postcode,
                      photoUrl: imageSrc,
                      foodType: foodType,
                      description: description,
                      date: date,
                    ))),
            child: const Text("Details"))
      ],
    );
  }
}
