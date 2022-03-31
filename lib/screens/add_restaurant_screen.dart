// ignore_for_file: prefer_final_fields

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_form_field/image_form_field.dart';
import 'package:restaurant_reviews/widgets/image_input_adapter.dart';
import 'package:restaurant_reviews/widgets/upload_button.dart';
import 'package:http/http.dart' as http;

class AddRestaurantScreen extends StatefulWidget {
  final username;
  AddRestaurantScreen(this.username);
  @override
  _AddRestaurantScreenState createState() => _AddRestaurantScreenState();
}

class _AddRestaurantScreenState extends State<AddRestaurantScreen> {
  final _formKey = GlobalKey<FormState>();
  late String restaurantName;
  late String postcode;
  late String photoUrl;
  late String foodType;
  late DateTime dateTime;
  late String description;
  List<ImageInputAdapter>? _images;

  bool _isLoading = false;

  Future<void> _addRestaurant() async {
    final url = Uri.parse("http://10.0.2.2:5000/restaurant/add");
    final response = await http.post(url,body: jsonEncode({
      'username': widget.username,
      'name': restaurantName,
      'postcode': postcode,
      'foodType': foodType,
      'description': description,
      'dateTime': dateTime.toIso8601String(),
      'photoUrl': photoUrl
    }),
    );
   final decodedResponse = jsonDecode(response.body);
   print(decodedResponse);
  }


  void _submitForm() async {
    FocusScope.of(context).unfocus();
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    if(_images![0].isFile == true){
      final savedImage = await _images![0].save();
      photoUrl = savedImage!.originalUrl;
    }
    await _addRestaurant();
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add restaurant"),),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration:
                  const InputDecoration(labelText: "Restaurant Name"),
                  textInputAction: TextInputAction.next,
                  onChanged: (value){
                    restaurantName = value;
                    dateTime = DateTime.now();
                  },
                  onSaved: (value) {
                    restaurantName = value!;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please provide a name for restaurant";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),TextFormField(
                  decoration:
                  const InputDecoration(labelText: "Postcode"),
                  textInputAction: TextInputAction.next,
                  // onChanged: (value){
                  //   postcode = value;
                  // },
                  onSaved: (value) {
                    postcode = value!;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please provide the postcode";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),TextFormField(
                  decoration:
                  const InputDecoration(labelText: "Food Type"),
                  textInputAction: TextInputAction.next,
                  // onChanged: (value){
                  //   restaurantName = value;
                  //     dateTime = DateTime.now().toString();
                  // },
                  onSaved: (value) {
                    foodType = value!;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please provide the main food type";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),TextFormField(
                  decoration:
                  const InputDecoration(labelText: "Description"),
                  textInputAction: TextInputAction.newline,
                  minLines: 2,
                  maxLines: 10,
                  // onChanged: (value){
                  //   restaurantName = value;
                  //     dateTime = DateTime.now().toString();
                  // },
                  onSaved: (value) {
                    description = value!;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please provide a name for restaurant";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                ImageFormField(
                  shouldAllowMultiple: false,
                  previewImageBuilder: (_,image) => image.widgetize(),
                  buttonBuilder: (ctx, count) => PhotoUploadButton(
                      count: count, shouldAllowMultiple: false),
                  initializeFileAsImage: (file) =>
                      ImageInputAdapter(
                        file: UploadableImage(
                          file,
                          storagePath: 'restaurants/$restaurantName',
                        ),
                      ),
                  onSaved: (value) => _images = value as List<ImageInputAdapter>,
                  autovalidateMode: AutovalidateMode.always,
                  validator: (value){
                    print(value);
                    if(value!.isEmpty){
                      return 'Please provide an image';
                    }
                    else{
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                if(_isLoading) CircularProgressIndicator(),
                if(!_isLoading)
                  RaisedButton(
                    onPressed: _submitForm,
                    child: const Text("Submit"),
                    color: Theme.of(context).colorScheme.secondary,
                    textColor: Colors.white,
                  )
              ],
            ),
          ),

        ),
      ),
    );
  }
}
