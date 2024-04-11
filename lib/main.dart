import 'package:flutter/material.dart';
import 'package:srs7/post_list_page.dart';
import 'package:srs7/post_detail_page.dart';

void main() {
  runApp(MyApp());
}

final Map<String, WidgetBuilder> routes = {
  '/': (context) => PostListPage(),
  '/post_detail': (context) => PostDetailPage(),
};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      initialRoute: '/',
      routes: routes,
    );
  }
}
