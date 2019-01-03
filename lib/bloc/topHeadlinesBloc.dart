import 'blocBase.dart';
import 'dart:async';
import 'package:flutter_news/services/newsService.dart';
import 'package:flutter_news/models/article.dart';

class TopHeadlinesBloc implements BlocBase {


NewsService _newsService = NewsService();
  
  List<Article> _articles = List<Article>();
  //
  // Stream to handle the counter
  //

  StreamController<List<Article>> _topHeadlinesController = StreamController<List<Article>>();
  StreamSink<List<Article>> get _inAdd => _topHeadlinesController.sink;
  Stream<List<Article>> get outResults => _topHeadlinesController.stream;

  //
  // Stream to handle the action on the counter
  //
  StreamController _requestController = StreamController();
  StreamSink get requestHeadlinesCounter => _requestController.sink;

  TopHeadlinesBloc() {
    _requestController.stream
                     .listen(_requestTopHeadlines);
  }

  void dispose(){
    _requestController.close();
    _topHeadlinesController.close();
  }

  void _requestTopHeadlines(request) async {
    var result = await _newsService.getTopHeadlines(request.country, request.page);
    _articles.addAll(result.articles);
    _inAdd.add(_articles);
  }
}
