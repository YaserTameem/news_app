import 'package:flutter/material.dart';
import 'package:news_app/core/datasource/local_data/preferences_manager.dart';
import 'package:news_app/features/auth/login_screen.dart';

class OnboardingController with ChangeNotifier {
  int currantIndex = 0;
  bool isLastPage = false;
  final PageController pageController = PageController();

  onPageChange(int index) {
    currantIndex = index;
    if (index == 2) {
      isLastPage = true;
    } else {
      isLastPage = false;
    }
    notifyListeners();
  }

  onNextPage(BuildContext context) {
    if (!isLastPage) {
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      onFinish(context);
    }

    notifyListeners();
  }

  onFinish(BuildContext context) {
    PreferencesManager().setBool("onboarding_complete", true);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
    notifyListeners();
  }
}
