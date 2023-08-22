import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:music_player/screens/home_screen.dart';
import 'package:music_player/screens/search.dart';
import 'package:music_player/screens/settings.dart';
import 'library.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BottomNavigation createState() => _BottomNavigation();
}

class _BottomNavigation extends State<BottomNavigation> {
  int currentIndex = 0;
  static final List<Widget> _widgetOptions = [
    const HomeScreen(),
   const  SearchScreen(),
    const LibraryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.45),
              Colors.purpleAccent.withOpacity(.1),
            ],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              Padding(
                padding: const EdgeInsets.only(left: 35, top: 17),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingsScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.settings),
                ),
              ),
            ],
          ),
          body: Center(
            child: _widgetOptions.elementAt(currentIndex),
          ),
          bottomNavigationBar: GNav(
            onTabChange: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            selectedIndex: currentIndex,
            tabs: const [
              GButton(
                icon: (Icons.home),
                text: "Home",
                backgroundColor: Colors.black,
                textStyle: TextStyle(
                  color: Colors.white,
                ),
                iconColor: Colors.white,
              ),
              GButton(
                icon: (Icons.search),
                text: "Search",
                backgroundColor: Colors.black87,
                textStyle: TextStyle(
                  color: Colors.white,
                ),
                iconColor: Colors.white,
              ),
              GButton(
                icon: (Icons.library_add),
                text: "My Library",
                backgroundColor: Colors.black,
                textStyle: TextStyle(
                  color: Colors.white,
                ),
                iconColor: Colors.white,
              ),
            ],
          ),
        ));
  }
}
