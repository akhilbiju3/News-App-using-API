import 'package:flutter/material.dart';
import 'package:newsapp/controller/Bottom_navigation_controller/bottom_controller.dart';
import 'package:newsapp/global_widgets/constants/color_constants/color.dart';
import 'package:newsapp/view/screens/category_screen/category_screen.dart';
import 'package:newsapp/view/screens/search_screen/search.dart';
import 'package:newsapp/view/screens/home_screen/newsapp_home.dart';
import 'package:provider/provider.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  final screens = [NewsAppHome(), Search(), Category()];
  @override
  Widget build(BuildContext context) {
    var bottomNavigationProvider =
        Provider.of<BottomController>(context, listen: false);
    var bottomNavigationselection =
        Provider.of<BottomController>(context, listen: true);
    return Scaffold(
      body: screens[bottomNavigationProvider.selection],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: backgroundColor,
        currentIndex: bottomNavigationselection.selection,
        onTap: (value) => bottomNavigationProvider.updateIndex(value),
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Color.fromARGB(255, 237, 53, 65),
        fixedColor: Color(0xff7C040D),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: "Category"),
        ],
      ),
    );
  }
}
