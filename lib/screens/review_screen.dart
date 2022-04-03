import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:restaurant_reviews/providers/restaurant.dart';

class ReviewScreen extends StatefulWidget {
  final docId;
  final username;
  final postcode;
  final name;

  const ReviewScreen({Key? key, this.docId, this.username, this.postcode, this.name}) : super(key: key);
  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final commentController = TextEditingController();
  double _foodScore = 0;
  double _valueScore = 0;
  double _serviceScore = 0;
  bool isLoading = false;

  void submitReview() async {
    // print('entered');
    // print(widget.docId);
    if (commentController.value.text.isEmpty ||
        _foodScore == 0 ||
        _valueScore == 0 ||
        _serviceScore == 0) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please provide values for all fields"),
        backgroundColor: Theme.of(context).errorColor,
      ));
      return;
    }

    setState(() {
      isLoading = true;
    });
    final url = Uri.parse('https://all-restaurant-reviews.herokuapp.com/restaurant/addreview');
    // final url = Uri.parse('http://10.0.2.2:5000/restaurant/addreview');
    final response = await http.post(url,
        body: jsonEncode({
          'username': widget.username,
          'docId': widget.docId,
          'comment': commentController.value.text,
          'foodScore': _foodScore.toInt(),
          'valueScore': _valueScore.toInt(),
          'serviceScore': _serviceScore.toInt(),
        }));
    setState(() {
      isLoading = false;
    });
    // print(response.body);
    if (response.statusCode == 200) {
      Provider.of<Restaurants>(context,listen: false).getAllRestaurants();
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant Review'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text(widget.name,style: TextStyle(fontWeight: FontWeight.bold),),
              Text(widget.postcode,style: TextStyle(fontWeight: FontWeight.bold),),
              TextField(
                decoration: const InputDecoration(labelText: 'Comment'),
                controller: commentController,
                textInputAction: TextInputAction.newline,
                minLines: 2,
                maxLines: 5,
              ),
              SizedBox(
                height: 10,
              ),
              Text('Food:'),
              Slider(
                value: _foodScore,
                onChanged: (score) {
                  setState(() {
                    _foodScore = score;
                  });
                },
                divisions: 5,
                min: 0,
                max: 5,
                label: "${_foodScore.toInt()}",
              ),
              Text('Service:'),
              Slider(
                value: _serviceScore,
                onChanged: (score) {
                  setState(() {
                    _serviceScore = score;
                  });
                },
                divisions: 5,
                min: 0,
                max: 5,
                label: "${_serviceScore.toInt()}",
              ),
              Text('value:'),
              Slider(
                value: _valueScore,
                onChanged: (score) {
                  setState(() {
                    _valueScore = score;
                  });
                },
                divisions: 5,
                min: 0,
                max: 5,
                label: "${_valueScore.toInt()}",
              ),
              isLoading ? CircularProgressIndicator() : ElevatedButton(
                  onPressed: () {
                    submitReview();
                    FocusScope.of(context).unfocus();
                  },
                  child: Text('Submit')),
            ],
          ),
        ),
      ),
    );
  }
}
