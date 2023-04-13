import 'package:flutter/material.dart';

class NavigationRoute {
  final String name;
  final Icon icon;
  final Widget page;
  NavigationRoute({
    required this.name,
    required this.icon,
    required this.page,
  });
}
