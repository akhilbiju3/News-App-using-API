import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/model/newsapp_model_class/news_app_model_class.dart';
import 'package:newsapp/utils/color_constants/color.dart';
import 'package:newsapp/view/screens/breaking_details/breaking_details.dart';
import 'package:newsapp/view/screens/carousal/carousalslider.dart';

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
        body: SingleChildScrollView(
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
              Padding(
                padding: const EdgeInsets.only(
                  left: 13.0,
                ),
                child: Text("Latest News",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: backgroundColor)),
              ),
              CarousalSlider(),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 13.0,
                ),
                child: Text("Breaking News",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: backgroundColor)),
              ),
              SizedBox(
                height: 5,
              ),
              ListView.builder(
                itemBuilder: (context, index) => InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => BreakingNews(),
                  )),
                  child: ListTile(
                      leading: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: NetworkImage(modelResponse!
                                    .articles![index].urlToImage
                                    .toString()),
                                fit: BoxFit.cover)),
                      ),
                      title: Text(
                          modelResponse!.articles![index].title.toString())),
                ),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 10,
              )
            ],
          ),
        ));
  }
}