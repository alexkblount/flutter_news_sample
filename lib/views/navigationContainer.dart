
import 'package:flutter/material.dart';
import '../services/newsService.dart';
import 'topHeadlinesWidget.dart';
import 'package:flutter_news/bloc/topHeadlinesBloc.dart';
import 'package:flutter_news/bloc/blocProvider.dart';
class NavigationContainer extends StatefulWidget {
 @override
 State<StatefulWidget> createState() {
    return _NavigationContainerState();
  }
}

class _NavigationContainerState extends State<NavigationContainer> {
 NewsService newsService = NewsService();
 int _currentIndex = 0;
 final List<Widget> _children = [
    BlocProvider<TopHeadlinesBloc>(
      bloc: TopHeadlinesBloc(),
        child: TopHeadlinesWidget(),
    ),
    BlocProvider<TopHeadlinesBloc>(
      bloc: TopHeadlinesBloc(),
        child: TopHeadlinesWidget(),
    ),
    BlocProvider<TopHeadlinesBloc>(
      bloc: TopHeadlinesBloc(),
        child: TopHeadlinesWidget(),
    )
  ];
 
 @override
 Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text('Flutter News'),
     ),
     body: _children[_currentIndex],
     bottomNavigationBar: BottomNavigationBar(
       onTap: onTabTapped, // new
       currentIndex: _currentIndex, // this will be set when a new tab is tapped
       items: [
         BottomNavigationBarItem(
           icon: new Icon(Icons.home),
           title: new Text('Home'),
         ),
         BottomNavigationBarItem(
           icon: new Icon(Icons.mail),
           title: new Text('Messages'),
         ),
         BottomNavigationBarItem(
           icon: Icon(Icons.person),
           title: Text('Profile')
         )
       ],
     ),
   );
 }

 void onTabTapped(int index) async {
   //var news = await newsService.getTopHeadlines('us');
   setState(() {
     _currentIndex = index;
     
   });
 }
}