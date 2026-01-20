import 'package:flutter/material.dart';
import 'package:news_app/core/theme/light_colors.dart';
import 'package:news_app/features/auth/login_screen.dart';
import 'package:news_app/features/onboarding/controllers/onboarding_controller.dart';
import 'package:news_app/features/onboarding/models/onboarding_model.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext _) {
    return ChangeNotifierProvider(
      create: (_) => OnboardingController(),
      builder: (context, _) {
        final controller = context.read<OnboardingController>();
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            actions: [
              Consumer<OnboardingController>(
                builder: (BuildContext context, value, Widget? child) {
                  return value.isLastPage
                      ? TextButton(
                        onPressed: () {
                          value.onFinish(context);
                        },
                        child: Text('Skip'),
                      )
                      : SizedBox();
                },
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    physics: BouncingScrollPhysics(),
                    controller: controller.pageController,
                    onPageChanged: controller.onPageChange,
                    itemCount: OnboardingModel.onboardingContent.length,
                    itemBuilder: (context, index) {
                      final page = OnboardingModel.onboardingContent[index];
                      return Column(
                        children: [
                          Image.asset(page.image),
                          SizedBox(height: 24),
                          Text(
                            page.title,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4E4B66),
                            ),
                          ),
                          SizedBox(height: 12),
                          Text(
                            textAlign: TextAlign.center,
                            page.supTitle,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF6E7191),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Consumer<OnboardingController>(
                  builder: (
                    BuildContext context,
                    OnboardingController value,
                    Widget? child,
                  ) {
                    return SmoothPageIndicator(
                      controller: value.pageController,
                      count: OnboardingModel.onboardingContent.length,
                      effect: SwapEffect(
                        dotWidth: 14,
                        dotHeight: 14,
                        spacing: 6,
                        dotColor: Color(0xFFD3D3D3),
                        activeDotColor: LightColors.primaryColor,
                      ),
                    );
                  },
                ),
                SizedBox(height: 112),
                Consumer<OnboardingController>(
                  builder: (
                    BuildContext context,
                    OnboardingController value,
                    Widget? child,
                  ) {
                    return ElevatedButton(
                      onPressed: () {
                        value.onNextPage(context);
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(MediaQuery.of(context).size.width, 48),
                      ),
                      child: Visibility(
                        replacement: Text('Get Started'),
                        visible: !value.isLastPage,
                        child: Text('Next'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
