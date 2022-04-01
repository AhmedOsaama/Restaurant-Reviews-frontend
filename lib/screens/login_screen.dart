import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_reviews/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late String username;
  late String password;
  bool isLoading = false;

  Future<void> signIn() async {
    isLoading = true;
    FocusScope.of(context).unfocus();
    bool isValid = _formKey.currentState!.validate();


    if (isValid) {
      _formKey.currentState!.save();
      print(username);
      print(password);
      try {
        var url = Uri.parse("http://10.0.2.2:5000/user/login");
        final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'username': username, 'pass': password}),
        );
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
        if (response.statusCode == 200) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => HomeScreen(username: username,)));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(response.body),
            backgroundColor: Theme.of(context).errorColor,
          ));
        }
      } catch (error) {
        print(error);
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: Material(
            borderRadius: BorderRadius.circular(10),
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Login',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      key: const ValueKey('username'),
                      decoration: const InputDecoration(labelText: "Username"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Invalid username';
                        }
                      },
                      onSaved: (value) {
                        username = value!;
                      },
                    ),
                    TextFormField(
                      key: const ValueKey('password'),
                      decoration: const InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Invalid password';
                        }
                      },
                      onSaved: (value) {
                        password = value!;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : RaisedButton(
                              onPressed: signIn,
                              child: const Text("Login"),
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                              onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => HomeScreen())),
                              child: const Text("Back to home"),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
