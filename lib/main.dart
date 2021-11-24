import 'package:flutter/material.dart';
import 'package:unsplash_pictures_bloc/pages/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Uspalsh Bloc',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: const MainScreenPage(),
        appBar: AppBar(
          centerTitle: true,
          title: Text('unsplash'),
        ),
      ),
    );
  }
}
