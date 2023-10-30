import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:newsapp/model/newsapp_model_class/news_app_model_class.dart';
import 'package:http/http.dart' as http;

class SearchBarController extends ChangeNotifier {
  bool isLoading = false;
  PublicApiRsponse? searchNews;
  Future<void> searchData({String? searchQuery = "Trending"}) async {
    isLoading = true;
    notifyListeners();

    final url = Uri.parse(
        "https://newsapi.org/v2/everything?q=$searchQuery&apiKey=5755fbbf963843daa9cbf625323f06c1");
    var response = await http.get(url);
    print(response.statusCode);
    print(response.body);
    searchNews = PublicApiRsponse.fromJson(jsonDecode(response.body));
    isLoading = false;
    notifyListeners();
    print("Loading stopped");
    print("$searchQuery");
  }
}
