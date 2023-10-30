import 'dart:async';

import 'package:flutter/material.dart';
import 'package:newsapp/utils/color_constants/color.dart';
import 'package:provider/provider.dart';
import 'package:newsapp/controller/search_controller/search_controller.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchText = TextEditingController();
  Timer? _debounceTimer;

  @override
  void dispose() {
    _debounceTimer?.cancel(); // Cancel the timer when disposing of the screen
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var searchProvider =
        Provider.of<SearchBarController>(context, listen: false);
    return Scaffold(
      body: Consumer<SearchBarController>(
        builder: (context, searchProvider, child) {
          return searchProvider.isLoading
              ? Center(child: const CircularProgressIndicator())
              : RefreshIndicator(
                  onRefresh: () {
                    return Future.wait([
                      searchProvider.searchData(),
                    ]);
                  },
                  child: SafeArea(
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0, left: 15),
                            child: Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: TextField(
                                    controller: searchText,
                                    onChanged: (value) {
                                      if (_debounceTimer != null &&
                                          _debounceTimer!.isActive) {
                                        _debounceTimer!
                                            .cancel(); // Cancel previous timer
                                      }

                                      // Debounce user input to wait for some time before triggering search
                                      _debounceTimer = Timer(
                                          Duration(milliseconds: 300), () {
                                        searchProvider.searchData(
                                            searchQuery: searchText.text);
                                      });
                                    },
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
                          SizedBox(
                            height: 10,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount:
                                searchProvider.searchNews?.articles?.length ??
                                    0,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image: NetworkImage(searchProvider
                                                  .searchNews
                                                  ?.articles?[index]
                                                  .urlToImage
                                                  .toString() ??
                                              ""),
                                          fit: BoxFit.cover)),
                                ),
                                title: Text(searchProvider
                                        .searchNews?.articles?[index].title!
                                        .toString() ??
                                    "Null"),
                                subtitle: Text(searchProvider
                                        .searchNews?.articles?[index].author!
                                        .toString() ??
                                    "Null"),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
