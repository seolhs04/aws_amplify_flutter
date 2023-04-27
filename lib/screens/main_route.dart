import 'package:aws_amplify_flutter/models/route_model.dart';
import 'package:aws_amplify_flutter/stores/counter_cubit.dart';
import 'package:aws_amplify_flutter/widgets/common/animated_indexed_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home/main.dart';
import 'maps/main.dart';
import 'settings/main.dart';
import 'todos/main.dart';

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
    name: 'Todos',
    icon: const Icon(Icons.list_alt),
    page: const TodosScreen(),
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
    return BlocProvider(
      create: (_) => CounterCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('App'),
        ),
        body: AnimatedIndexedStack(
          index: _currentIndex,
          duration: const Duration(milliseconds: 200),
          children: _routes.map((route) => route.page).toList(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: _onPageChanged,
          items: _routes.map((route) {
            return BottomNavigationBarItem(icon: route.icon, label: route.name);
          }).toList(),
        ),
      ),
    );
  }
}
