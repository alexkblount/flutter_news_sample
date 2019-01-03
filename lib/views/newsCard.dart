import 'package:flutter/material.dart';
import '../models/article.dart';

class NewsCard extends Card {
  final Article article;
  NewsCard(this.article);

  @override
  Widget build(BuildContext context) {
    return Center(
          child: Column(children: <Widget>[
        article.urlToImage != null
            ? FadeInImage.assetNetwork(
                placeholder: 'assets/default-placeholder.png',
                image: article.urlToImage,)
            : Image.asset('assets/default-placeholder.png', fit: BoxFit.fill),
            Text(article.title ?? '')
      ]),);
  }
}
