import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quantam/News/utils/app_constants.dart';
import 'package:quantam/News/utils/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/News.dart';

class NewsRepository {
  Future getAllNews(query) async {
    http.Response response = await http.get(Uri.parse(
        AppConstants.base + query + AppConstants.trailing + AppConstants.key));
    if (response.statusCode == 200) {
      var result = json.decode(response.body);

      NewsModel news = NewsModel.fromJson(result);
      return news;
    } else {
      throw (Exception(ErrorMessage.statusNot200));
    }
  }

  Future buildFromLocalData() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(AppConstants.localNewsKey)) {
      String? data = prefs.getString(AppConstants.localNewsKey);
      var decodedData = jsonDecode(data as String);

      NewsModel model = NewsModel.fromJson(decodedData);
      return model;
    } else {
      throw Error();
    }
  }

  Future getTopHeadlines() async {
    http.Response response =
        await http.get(Uri.parse(AppConstants.topHeadlines));
    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      if (!prefs.containsKey(AppConstants.localNewsKey)) {
        prefs.setString(AppConstants.localNewsKey, response.body);
      }
      var result = json.decode(response.body);

      NewsModel news = NewsModel.fromJson(result);
      return news;
    } else {
      throw (Exception(ErrorMessage.statusNot200));
    }
  }
}
