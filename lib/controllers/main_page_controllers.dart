import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/features/movie/presentation/pages/movie_list_page.dart';

final mainPageControllerProvider = ChangeNotifierProvider<MainPageController>(
  (ref) => MainPageController(),
);

class MainPageController extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  final List<Widget> _pages = [
    const MovieListPage(),
    Container(), // Placeholder para la página de favoritos
  ];

  List<Widget> get pages => _pages;

  void onItemTapped(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
