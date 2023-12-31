import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../model/newsapp_category_model_class/category_model_class.dart';

class CategoryController extends ChangeNotifier {
  bool isLoading = false;
  CategoryApiRsponse? categoryResponse;
  Future<void> categoryData({required String? categoryQuery}) async {
    isLoading = true;
    notifyListeners();

    final url = Uri.parse(
        "https://newsapi.org/v2/top-headlines/sources?category=$categoryQuery&apiKey=5755fbbf963843daa9cbf625323f06c1");
    try {
      var cresponse = await http.get(url);

      print(cresponse.statusCode);
      print(cresponse.body);
      if (cresponse.statusCode == 200) {
        print("Success");
        categoryResponse =
            CategoryApiRsponse.fromJson(jsonDecode(cresponse.body));
      } else {
        print("Failed");
      }

      isLoading = false;
      notifyListeners();
      print("Loading stopped");
      print(categoryQuery);
    } catch (e) {
      print(e);
      isLoading = false;
      notifyListeners();
    }
  }
}
