import 'package:flutter/material.dart';
import 'package:newsapp/controller/Bottom_navigation_controller/bottom_controller.dart';
import 'package:newsapp/controller/home_screen_controller/home_screen_controller.dart';
import 'package:newsapp/view/screens/bottom_naviagtion/bottom_navi_widget/bottom_navi.dart';
import 'package:newsapp/view/screens/newsapp_home/newsapp_home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeScreenController()),
        ChangeNotifierProvider(create: (_) => BottomController())],
      child: MaterialApp( 
        
        debugShowCheckedModeBanner: false,
        home: BottomNavigation(),
      ),
    );
  }
}
