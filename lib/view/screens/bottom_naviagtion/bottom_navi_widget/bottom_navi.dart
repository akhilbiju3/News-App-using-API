import 'package:flutter/material.dart';
import 'package:newsapp/controller/Bottom_navigation_controller/bottom_controller.dart';
import 'package:newsapp/utils/color_constants/color.dart';
import 'package:newsapp/view/screens/bottom_naviagtion/profile.dart';
import 'package:newsapp/view/screens/bottom_naviagtion/search.dart';
import 'package:newsapp/view/screens/newsapp_home/newsapp_home.dart';
import 'package:provider/provider.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {

  

  final screens = [NewsAppHome(), Search(), Profile()];
  @override
  Widget build(BuildContext context) {
    var bottomNavigationProvider = Provider.of<BottomController>(context,listen: false);
    var bottomNavigationselection = Provider.of<BottomController>(context,listen: true);
    return Scaffold(
      body: screens[bottomNavigationProvider.selection],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomNavigationselection.selection,
        onTap: (value) => bottomNavigationProvider.updateIndex(value),
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey,
        fixedColor: backgroundColor,
        items:  [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
