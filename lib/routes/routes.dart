import 'package:flutter/material.dart';
import 'package:movie_app/pages/main_layout_page.dart';
import 'package:movie_app/pages/search_page.dart';

class RouteManager {
  static const String mainLayoutPage = '/';
  static const String searchPage = '/searchPage';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case mainLayoutPage:
        return MaterialPageRoute(builder: (context) => const MainLayoutPage());
      case searchPage:
        return MaterialPageRoute(builder: (context) => const SearchPage());
      default:
        throw const FormatException('Route not Found!');
    }
  }
}
