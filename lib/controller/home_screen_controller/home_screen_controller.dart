import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:newsapp/model/newsapp_model_class/news_app_model_class.dart';
import 'package:http/http.dart' as http;

class HomeScreenController extends ChangeNotifier {
  bool isLoading = false;
  PublicApiRsponse? latestNews;
  PublicApiRsponse? breakingNews;
  int currentSlider = 0;
  void carosualUpdate(int index) {
    currentSlider = index;
    notifyListeners();
  }

  Future<void> latestNewsData() async {
    isLoading = true;
    notifyListeners();

    final url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=us&apiKey=5755fbbf963843daa9cbf625323f06c1");
    var response = await http.get(url);
    print(response.statusCode);
    print(response.body);
    latestNews = PublicApiRsponse.fromJson(jsonDecode(response.body));
    isLoading = false;
    notifyListeners();
  }
  Future<void> breakingNewsData() async {
    isLoading = true;
    notifyListeners();

    final url = Uri.parse(
        "https://newsapi.org/v2/everything?q=keyword&apiKey=5755fbbf963843daa9cbf625323f06c1");
    var response = await http.get(url);
    print(response.statusCode);
    print(response.body);
    breakingNews = PublicApiRsponse.fromJson(jsonDecode(response.body));
    isLoading = false;
    notifyListeners();
  }
}
