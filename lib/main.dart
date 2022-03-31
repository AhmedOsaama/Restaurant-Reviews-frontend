import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_reviews/firebase_options.dart';
import 'package:restaurant_reviews/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restaurant Reviews',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        accentColor: Colors.brown[300]
      ),
      home: LoginScreen(),
    );
  }
}

