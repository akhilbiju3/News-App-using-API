import 'package:flutter/material.dart';
import 'package:newsapp/utils/color_constants/color.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController SearchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 15),
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextField(
                    controller: SearchController,
                    // onChanged: (value) =>
                    //     homeScreenProvider.fetchData(
                    //         searchQuery: SearchController.text),
                    decoration: InputDecoration(
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                  radius: 25,
                  backgroundColor: backgroundColor,
                  child: Icon(
                    Icons.notifications_none_outlined,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ],
      )),
    );
  }
}
