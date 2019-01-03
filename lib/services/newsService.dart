import 'dart:convert';
//mport '../models/weather_info.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../models/newsResult.dart';
import '../keys.dart';

class NewsService {

  
  final String baseUrl = 'https://newsapi.org/v2/';
  final int pageSize = 20;

  Future<NewsResult> getTopHeadlines (String country, int page) async {

    var url = '${baseUrl}top-headlines?country=$country&apiKey=${Keys.apiKey}&pageSize=${this.pageSize}&page=$page';
    var response = await http.get(url);
    Map data = json.decode(response.body);
    return NewsResult.fromJson(data);
  }
}