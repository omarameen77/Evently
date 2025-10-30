import 'package:evently/core/theme/app_colors.dart';
import 'package:evently/features/home/taps/add_event/add_event.dart';
import 'package:evently/features/home/taps/home/home_tab.dart';
import 'package:evently/features/home/taps/love/love_tab.dart';
import 'package:evently/features/home/taps/profile/profile_tab.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int myIndex = 0;
  final List<Widget> pages = [
    HomeTabScreen(),
    Center(child: Text('Map Page')),
    LoveTabScreen(),
    ProfileTabScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddEventScreen()));
          },
          shape: CircleBorder(side: BorderSide(color: Colors.white, width: 3)),
          child: Icon(
            Icons.add,
            color: AppColors.offWhite,
          ),
        ),
        bottomNavigationBar: Directionality(
          textDirection: TextDirection.ltr,
          child: SizedBox(
            height: 70,
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                setState(() {
                  myIndex = index;
                });
              },
              currentIndex: myIndex,
              items: [
                BottomNavigationBarItem(
                  icon: myIndex == 0
                      ? const Icon(Icons.home)
                      : const Icon(Icons.home_outlined),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: myIndex == 1
                      ? const Icon(Icons.location_on)
                      : const Icon(Icons.location_on_outlined),
                  label: 'Map',
                ),
                BottomNavigationBarItem(
                  icon: myIndex == 2
                      ? const Icon(Icons.favorite)
                      : const Icon(Icons.favorite_border),
                  label: 'Love',
                ),
                BottomNavigationBarItem(
                  icon: myIndex == 3
                      ? const Icon(Icons.person)
                      : const Icon(Icons.person_outline),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
        body: IndexedStack(index: myIndex, children: pages));
  }
}
