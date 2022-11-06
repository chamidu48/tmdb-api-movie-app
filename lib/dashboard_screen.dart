import 'package:flutter/material.dart';
import 'package:tmdb_api_movie_app/Services/send_receive_data.dart';
import 'package:tmdb_api_movie_app/explore_screen.dart';
import 'package:tmdb_api_movie_app/saved_screen.dart';
import 'package:tmdb_api_movie_app/search_screen.dart';
import 'package:tmdb_api_movie_app/settings_screen.dart';
import 'Services/api_data.dart';
import 'Services/send_receive_data.dart';
import 'drawer.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  final List<Widget> screens= [ExploreScreen(),SearchPage(),SavedPage(),SettingsPage()];
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildDrawer(),
      body: screens[activeIndex],
      backgroundColor: Color(0xff343434),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: activeIndex,
        selectedItemColor: Color(0xffF61010),
        unselectedItemColor: Color(0xffe2e2e2),
        backgroundColor: Color(0xff393939),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home',),
          BottomNavigationBarItem(icon: Icon(Icons.search),label: 'Seach'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'Saved'),
          BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings')
        ],
        onTap: (value) {
          setState(() {
            activeIndex = value;
          });
        },
      ),
    );
  }
}

