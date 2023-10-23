import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/model/newsapp_model_class/news_app_model_class.dart';
import 'package:newsapp/utils/color_constants/color.dart';

class NewsAppHome extends StatefulWidget {
  const NewsAppHome({super.key});

  @override
  State<NewsAppHome> createState() => _NewsAppHomeState();
}

class _NewsAppHomeState extends State<NewsAppHome> {
  bool isLoading = true;

  PublicApiRsponse? modelResponse;

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=5755fbbf963843daa9cbf625323f06c1");

    var response = await http.get(url);
    print(response.statusCode);
    print(response.body);
    modelResponse = PublicApiRsponse.fromJson(jsonDecode(response.body));

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: backgroundColor,
          title: const Text('News App'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15.0, left: 15),
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
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
        ));
  }
}

// isLoading
//             ? Center(child: CircularProgressIndicator())
//             : ListView.builder(
//                 itemCount: modelResponse?.articles?.length ?? 0,
//                 itemBuilder: (context, index) => Container(
//                   margin: EdgeInsets.all(10),
//                   color: Colors.grey[300],
//                   child: Text(
//                     modelResponse?.articles?[index].description ?? "Loading",
//                     style: TextStyle(color: Colors.red),
//                   ),
//                 ),
//               )