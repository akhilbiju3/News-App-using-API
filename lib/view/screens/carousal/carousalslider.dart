import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/controller/home_screen_controller/home_screen_controller.dart';
import 'package:provider/provider.dart';

class CarousalSlider extends StatefulWidget {
  const CarousalSlider({super.key});

  @override
  State<CarousalSlider> createState() => _CarousalSliderState();
}

class _CarousalSliderState extends State<CarousalSlider> {
  int currentSlider = 0;
  GlobalKey<CarouselSliderState> sliderKey = GlobalKey();

  

  @override
  Widget build(BuildContext context) {
    var carousalSlider = Provider.of<HomeScreenController>(context);
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
                itemCount: carousalSlider.latestNews?.articles?.length ?? 0,
                itemBuilder: (context, index, realIndex) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width * 1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: NetworkImage(carousalSlider
                                    .latestNews?.articles?[index].urlToImage
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
                    carousalSlider.carosualUpdate(index);

                    print(carousalSlider.currentSlider);
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
                    carousalSlider.latestNews
                            ?.articles?[carousalSlider.currentSlider].title ??
                        "No Title",
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
