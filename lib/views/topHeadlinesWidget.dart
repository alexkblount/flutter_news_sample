import 'package:flutter/material.dart';
import '../models/topHeadlinesRequest.dart';
import 'newsCard.dart';
import 'package:flutter_news/bloc/topHeadlinesBloc.dart';
import 'package:flutter_news/bloc/blocProvider.dart';

class TopHeadlinesWidget extends StatelessWidget {
  /*@override
 State<StatefulWidget> createState() {
    return _TopHeadlinesWidget();
  }*/
  @override
  Widget build(BuildContext context) {
    int page = 0;

    final TopHeadlinesBloc topHeadlinesBloc =
        BlocProvider.of<TopHeadlinesBloc>(context);
    topHeadlinesBloc.requestHeadlinesCounter
        .add(TopHeadlinesRequest('us', page));
    final ScrollController scrollController = ScrollController();
    final handleScroll = () {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        page++;
        topHeadlinesBloc.requestHeadlinesCounter
            .add(TopHeadlinesRequest('us', page));
      }
    };
    scrollController.addListener(handleScroll);
    return StreamBuilder(
      stream: topHeadlinesBloc.outResults,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error);
        }
        if (snapshot.hasData) {
          return new Container(
            color: Colors.white30,
            child: GridView.builder(
              itemCount: snapshot.data?.length ?? 0,
              controller: scrollController,
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1, childAspectRatio: 1),
              itemBuilder: (BuildContext context, int index) {
                return new NewsCard(snapshot.data[index]);
              },
            ),
          );
        }
        if (snapshot.connectionState != ConnectionState.done) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
          return Text('No Posts');
        }
      },
    );
  }
}
