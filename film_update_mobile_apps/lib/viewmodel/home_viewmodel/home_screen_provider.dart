import 'package:flutter/material.dart';

enum PageSection { home, favorite, contactMe }

class HomeScreenProvider extends ChangeNotifier {
  PageSection pageSection = PageSection.home;

  void changeSection(PageSection newPageSection) {
    pageSection = newPageSection;
    notifyListeners();
  }
}
