import 'package:flutter/material.dart';
import 'package:newsapp/view/newsapp_home/newsapp_home.dart';

void main() {
  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp( 
      debugShowCheckedModeBanner: false,
      home: NewsAppHome(),
    );
  }
}
