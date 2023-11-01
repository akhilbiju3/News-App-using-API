import 'package:flutter/material.dart';
import 'package:newsapp/global_widgets/constants/color_constants/color.dart';
import 'package:share_plus/share_plus.dart';

class BreakingNews extends StatefulWidget {
  final int selectedIndex;
  final newsDataProvider;

  const BreakingNews({
    super.key,
    required this.selectedIndex,
    required this.newsDataProvider,
  });

  @override
  State<BreakingNews> createState() => _BreakingNewsState();
}

class _BreakingNewsState extends State<BreakingNews> {
  @override
  Widget build(BuildContext context) {
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
                        image: NetworkImage(widget.newsDataProvider
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
              Positioned(
                bottom: 10,
                left: 320,
                child: Row(
                  children: [
                    Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white.withOpacity(.89),
                        ),
                        child: InkWell(
                          child: Icon(Icons.share),
                          onTap: () {
                            Share.share(widget.newsDataProvider
                                    ?.articles?[widget.selectedIndex].title
                                    .toString() ??
                                "");
                          },
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white.withOpacity(.89),
                        ),
                        child: Icon(Icons.bookmark_border)),
                  ],
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
                    widget.newsDataProvider?.articles?[widget.selectedIndex]
                            .title
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
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Text(
                          "${widget.newsDataProvider?.articles?[widget.selectedIndex].author.toString() ?? ""} | ${widget.newsDataProvider?.articles?[widget.selectedIndex].publishedAt.toString() ?? ""}",
                          style: TextStyle(fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 2,
                    indent: 0,
                  ),
                  Text(
                    widget.newsDataProvider?.articles?[widget.selectedIndex]
                            .description
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
