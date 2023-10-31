import 'dart:async';

import 'package:flutter/material.dart';
import 'package:newsapp/utils/color_constants/color.dart';
import 'package:newsapp/view/screens/breaking_details/breaking_details.dart';
import 'package:provider/provider.dart';
import 'package:newsapp/controller/search_controller/search_controller.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var searchProvider =
        Provider.of<SearchBarController>(context, listen: false);
    return Scaffold(
        body: searchProvider.isLoading
            ? Center(child: const CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: () {
                  return Future.wait([
                    searchProvider.searchData(),
                  ]);
                },
                child: SafeArea(
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
                                controller: searchText,
                                onChanged: (value) {
                                  searchProvider.searchData(
                                      searchQuery: searchText.text);
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
                      Expanded(
                        child: SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          child: Consumer<SearchBarController>(
                            builder: (context, searchProvider, child) {
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount:
                                    searchProvider.searchNews?.articles?.length,
                                itemBuilder: (context, searchindex) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BreakingNews(
                                                    selectedIndex: searchindex,
                                                    newsDataProvider:
                                                        searchProvider
                                                            .searchNews,
                                                  )));
                                    },
                                    child: ListTile(
                                      leading: Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    searchProvider
                                                            .searchNews
                                                            ?.articles?[
                                                                searchindex]
                                                            .urlToImage
                                                            .toString() ??
                                                        " "),
                                                fit: BoxFit.cover)),
                                      ),
                                      title: Text(searchProvider.searchNews
                                              ?.articles?[searchindex].title
                                              .toString() ??
                                          "Null"),
                                      subtitle: Text(searchProvider.searchNews
                                              ?.articles?[searchindex].author
                                              .toString() ??
                                          "Null"),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
  }
}
