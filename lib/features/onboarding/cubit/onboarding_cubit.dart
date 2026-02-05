import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/datasource/local_data/preferences_manager.dart';
import 'package:news_app/features/auth/login_screen.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingState());
  final PageController pageController = PageController();

  onPageChange(int index) {
    if (index == 2) {
      emit(state.copyWith(currantIndex: index, isLastPage: true));
    } else {
      emit(state.copyWith(currantIndex: index, isLastPage: false));
    }
  }

  onNextPage(BuildContext context) {
    if (!state.isLastPage) {
      pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      onFinish(context);
    }
  }

  onFinish(BuildContext context) {
    PreferencesManager().setBool("onboarding_complete", true);
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
