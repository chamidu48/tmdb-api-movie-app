import 'package:flutter/material.dart';
import 'package:tmdb_api_movie_app/dashboard_screen.dart';
import 'package:tmdb_api_movie_app/saved_screen.dart';
import 'package:tmdb_api_movie_app/search_screen.dart';
import 'package:tmdb_api_movie_app/settings_screen.dart';

import 'explore_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TMDB API TEST APP',
      routes: {
        '/':(context)=> Dashboard(),
        '/explore':(context) => ExploreScreen(),
        '/saved':(context)=> SavedPage(),
        '/settings':(context)=> SettingsPage()
      },
    );
  }
}

