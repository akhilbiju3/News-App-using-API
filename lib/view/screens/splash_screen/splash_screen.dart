import 'package:flutter/material.dart';
import 'package:newsapp/global_widgets/constants/color_constants/color.dart';
import 'package:newsapp/view/screens/bottom_naviagtion/bottom_navi_widget/bottom_navi.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5)).then(
        (value) => Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => BottomNavigation(),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor, 
      body: Center(
        child: SizedBox(
            height: 150,
            width: 150,
            child: Image.asset(
              "assets/logo/News (2).png",
              fit: BoxFit.cover,
            )),
      ),
    );
  }
}
