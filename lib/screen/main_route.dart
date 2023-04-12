import 'package:flutter/material.dart';
import 'package:hakdong_place/screen/home_screen.dart';
import 'package:hakdong_place/screen/maps_screen.dart';
import 'package:hakdong_place/screen/settings_screen.dart';
import 'package:hakdong_place/widget/AnimatedIndexedStack.dart';

import '../model/route_model.dart';

final List<NavigationRoute> _routes = [
  NavigationRoute(
    name: 'Home',
    icon: const Icon(Icons.home),
    page: const HomeScreen(),
  ),
  NavigationRoute(
    name: 'Maps',
    icon: const Icon(Icons.map_outlined),
    page: const MapsScreen(),
  ),
  NavigationRoute(
    name: 'Settings',
    icon: const Icon(Icons.settings),
    page: const SettingsScreen(),
  ),
];

class MainRoute extends StatefulWidget {
  const MainRoute({Key? key}) : super(key: key);

  @override
  _MainRouteState createState() => _MainRouteState();
}

class _MainRouteState extends State<MainRoute> {
  late PageController _pageController;
  int _currentIndex = 0;

  void _onPageChanged(int index) {
    if (_currentIndex == index) return;
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My App'),
      ),
      body: AnimatedIndexedStack(
        index: _currentIndex,
        duration: const Duration(milliseconds: 200),
        children: _routes.map((route) => route.page).toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onPageChanged,
        items: _routes.map((route) {
          return BottomNavigationBarItem(icon: route.icon, label: route.name);
        }).toList(),
      ),
    );
  }
}
