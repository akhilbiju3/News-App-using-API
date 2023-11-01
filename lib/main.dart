import 'package:flutter/material.dart';
import 'package:newsapp/controller/Bottom_navigation_controller/bottom_controller.dart';
import 'package:newsapp/controller/category_controller/categrory_controller.dart';
import 'package:newsapp/controller/home_screen_controller/home_screen_controller.dart';

import 'package:newsapp/view/screens/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';
import 'controller/search_controller/search_controller.dart';

void main() {
  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeScreenController()),
        ChangeNotifierProvider(create: (_) => BottomController()),
        ChangeNotifierProvider(create: (_) => SearchBarController()),
        ChangeNotifierProvider(
          create: (_) => CategoryController(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:Splashscreen(),
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(
              color: Color(0xff7C040D),
            ),
          ),
        ),
      ),
    );
  }
}
