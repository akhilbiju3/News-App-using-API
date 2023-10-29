import 'package:blinking_text/blinking_text.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/controller/Bottom_navigation_controller/bottom_controller.dart';

import 'package:newsapp/controller/home_screen_controller/home_screen_controller.dart';
import 'package:newsapp/model/newsapp_model_class/news_app_model_class.dart';
import 'package:newsapp/utils/color_constants/color.dart';
import 'package:newsapp/view/screens/breaking_details/breaking_details.dart';
import 'package:newsapp/view/screens/carousal/carousalslider.dart';
import 'package:provider/provider.dart';

class NewsAppHome extends StatefulWidget {
  const NewsAppHome({super.key});

  @override
  State<NewsAppHome> createState() => _NewsAppHomeState();
}

class _NewsAppHomeState extends State<NewsAppHome> {
  PublicApiRsponse? modelResponse;

  @override
  void initState(){
    fetchdata();
    super.initState();
  }

  Future<void> fetchdata() async{
    await Future.wait([
      Provider.of<HomeScreenController>(context, listen: false)
          .latestNewsData(),
      Provider.of<HomeScreenController>(context, listen: false)
          .breakingNewsData()
    ]);
  }

  @override
  Widget build(BuildContext context) {
    var homeScreenProvider = Provider.of<HomeScreenController>(context);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: backgroundColor,
          title: const Text('News App'),
          centerTitle: true,
        ),
        body: homeScreenProvider.isLoading
            ? Center(child: const CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: () {
                  return Future.wait([
                    homeScreenProvider.latestNewsData(),
                    homeScreenProvider.breakingNewsData()
                  ]);
                },
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      CarousalSlider(),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 13.0,
                        ),
                        child: BlinkText('Breaking News',
                            style: TextStyle(
                                fontSize: 22,
                                color: backgroundColor,
                                fontWeight: FontWeight.bold),
                            duration: Duration(seconds: 1)),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      ListView.separated(
                        separatorBuilder: (context, index) => Divider(),
                        itemBuilder: (context, index) => InkWell(
                          onTap: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => BreakingNews(selectedIndex: index,),
                          )),
                          child: ListTile(
                              leading: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: NetworkImage(homeScreenProvider
                                                .breakingNews
                                                ?.articles?[index]
                                                .urlToImage
                                                .toString() ??
                                            ""),
                                        fit: BoxFit.cover)),
                              ),
                              title: Text(homeScreenProvider
                                      .breakingNews?.articles?[index].title
                                      .toString() ??
                                  "No Title")),
                        ),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount:
                            homeScreenProvider.breakingNews?.articles?.length ??
                                0,
                      )
                    ],
                  ),
                ),
              ));
  }
}
