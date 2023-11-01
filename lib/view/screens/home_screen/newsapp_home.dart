import 'package:blinking_text/blinking_text.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:newsapp/controller/home_screen_controller/home_screen_controller.dart';
import 'package:newsapp/controller/search_controller/search_controller.dart';
import 'package:newsapp/global_widgets/constants/color_constants/color.dart';
import 'package:newsapp/view/screens/category_screen/category_screen.dart';
import 'package:newsapp/view/screens/search_screen/search.dart';
import 'package:newsapp/view/screens/details_screen/breaking_details.dart';
import 'package:newsapp/view/screens/carousal/carousalslider.dart';
import 'package:provider/provider.dart';

class NewsAppHome extends StatefulWidget {
  const NewsAppHome({super.key});

  @override
  State<NewsAppHome> createState() => _NewsAppHomeState();
}

class _NewsAppHomeState extends State<NewsAppHome> {
  @override
  void initState() {
    fetchdata();
    super.initState();
  }

  Future<void> fetchdata() async {
    await Future.wait([
      Provider.of<HomeScreenController>(context, listen: false)
          .latestNewsData(),
      Provider.of<HomeScreenController>(context, listen: false)
          .breakingNewsData(),
      Provider.of<SearchBarController>(context, listen: false).searchData(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    var homeScreenProvider = Provider.of<HomeScreenController>(context);
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: backgroundColor,
                ),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        "NEWS HUB",
                        style: TextStyle(
                            color: Color(0xff7C040D),
                            fontWeight: FontWeight.w700,
                            fontSize: 20),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Image.asset(
                        "assets/logo/News (2).png",
                        height: 80,
                        width: 80,
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => NewsAppHome()));
                },
              ),
              ListTile(
                leading: Icon(Icons.category),
                title: Text('Categories'),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Category()));
                },
              ),
              ListTile(
                leading: Icon(Icons.search),
                title: Text('Search'),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Search()));
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: backgroundColor,
          title: Padding(
            padding: const EdgeInsets.only(right: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/logo/News (2).png",
                  height: 80,
                  width: 80,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Text(
                    "NEWS HUB",
                    style: TextStyle(
                        color: Color(0xff7C040D),
                        fontWeight: FontWeight.w700,
                        fontSize: 20),
                  ),
                )
              ],
            ),
          ),
        ),
        body: homeScreenProvider.isLoading
            ? Center(
                child: LoadingAnimationWidget.inkDrop(
                    color: Color(0xff7C040D), size: 30))
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
                            builder: (context) => BreakingNews(
                                selectedIndex: index,
                                newsDataProvider:
                                    homeScreenProvider.breakingNews),
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
                                            "https://images.pexels.com/photos/4439425/pexels-photo-4439425.jpeg?auto=compress&cs=tinysrgb&w=400"),
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
