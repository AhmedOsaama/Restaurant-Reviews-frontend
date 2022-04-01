import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:intl/intl.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final name;
  final postcode;
  final photoUrl;
  final foodType;
  final date;
  final description;

  const RestaurantDetailScreen(
      {Key? key,
      this.name,
      this.postcode,
      this.photoUrl,
      this.foodType,
      this.date,
      this.description})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
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
              Text("Created: ${DateFormat().add_yMMMd().format(DateTime.parse(date))}"),
              const SizedBox(
                height: 10,
              ),
              MarkdownBody(data: description),
              // Text(description),
            ],
          ),
        ),
      ),
    );
  }
}
