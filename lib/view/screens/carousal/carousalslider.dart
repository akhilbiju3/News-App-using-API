import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/model/newsapp_model_class/news_app_model_class.dart';
import 'package:http/http.dart' as http;

class CarousalSlider extends StatefulWidget {
  const CarousalSlider({super.key});

  @override
  State<CarousalSlider> createState() => _CarousalSliderState();
}

class _CarousalSliderState extends State<CarousalSlider> {
  int currentSlider = 0;
  GlobalKey<CarouselSliderState> sliderKey = GlobalKey();
  PublicApiRsponse? modelResponse;
  Future<void> fetchData() async {
    final url = Uri.parse(
        "https://newsapi.org/v2/everything?q=keyword&apiKey=5755fbbf963843daa9cbf625323f06c1");

    var response = await http.get(url);
    print(response.statusCode);
    print(response.body);
    modelResponse = PublicApiRsponse.fromJson(jsonDecode(response.body));
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 250,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: CarouselSlider.builder(
                key: sliderKey,
                itemCount: modelResponse?.articles?.length ?? 0,
                itemBuilder: (context, index, realIndex) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width * 1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: NetworkImage(modelResponse
                                    ?.articles?[index].urlToImage
                                    .toString() ??
                                "https://readwrite.com/colorado-supreme-court-affirms-use-of-google-keyword-search-warrants/"),
                            fit: BoxFit.fill),
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                  autoPlay: true,
                  viewportFraction: 1,
                  height: MediaQuery.of(context).size.height * 0.5,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentSlider = index;
                      print("Page changed to index: $currentSlider");
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    modelResponse?.articles?[currentSlider].title ?? "No Title",
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
