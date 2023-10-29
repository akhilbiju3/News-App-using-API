import 'package:flutter/material.dart';
import 'package:newsapp/controller/home_screen_controller/home_screen_controller.dart';
import 'package:newsapp/utils/color_constants/color.dart';
import 'package:provider/provider.dart';

class BreakingNews extends StatefulWidget {
  final int selectedIndex;
  const BreakingNews({super.key, required this.selectedIndex});

  @override
  State<BreakingNews> createState() => _BreakingNewsState();
}

class _BreakingNewsState extends State<BreakingNews> {
  @override
  Widget build(BuildContext context) {
    var homeScreenProvider = Provider.of<HomeScreenController>(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 450,
                decoration: BoxDecoration(
                    color: backgroundColor,
                    image: DecorationImage(
                        image: NetworkImage(homeScreenProvider.breakingNews
                                ?.articles?[widget.selectedIndex].urlToImage
                                .toString() ??
                            ""),
                        fit: BoxFit.cover)),
              ),
              Positioned(
                top: 30,
                left: 10,
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(50)),
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: Icon(
                      Icons.arrow_back_outlined,
                      color: const Color.fromARGB(255, 48, 48, 48),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    homeScreenProvider
                            .breakingNews?.articles?[widget.selectedIndex].title
                            .toString() ??
                        "",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${homeScreenProvider.breakingNews?.articles?[widget.selectedIndex].author.toString() ?? ""} | ${homeScreenProvider.breakingNews?.articles?[widget.selectedIndex].publishedAt.toString() ?? ""}",
                        style: TextStyle(fontSize: 12),
                      ),
                      Row(
                        children: [
                          Icon(Icons.share),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(Icons.bookmark_border)
                        ],
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 2,
                    indent: 0,
                  ),
                  Text(
                    homeScreenProvider.breakingNews
                            ?.articles?[widget.selectedIndex].description
                            .toString() ??
                        "",
                    style: TextStyle(
                        fontSize: 16, height: 1.5, overflow: TextOverflow.fade),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
