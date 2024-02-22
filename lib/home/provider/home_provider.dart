import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  int selectedPage = 0;
  void changeSelectedPage(int newSelectedPage) {
    selectedPage = newSelectedPage;
    notifyListeners();
  }
}
