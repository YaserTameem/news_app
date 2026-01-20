import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_app/core/theme/light_colors.dart';
import 'package:news_app/features/main/main_controller.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext _) {
    return ChangeNotifierProvider(
      create: (_) => MainController(),
      builder: (context, _) {
        return Consumer<MainController>(
          builder: (BuildContext context, MainController value, Widget? child) {
            return Scaffold(
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: value.currentIndex,
                onTap: value.changeIndex,
                items: [
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      'assets/images/home_icon.svg',
                      colorFilter: ColorFilter.mode(
                        value.currentIndex == 0
                            ? LightColors.primaryColor
                            : LightColors.textSecondaryColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      'assets/images/search_icon.svg',
                      colorFilter: ColorFilter.mode(
                        value.currentIndex == 1
                            ? LightColors.primaryColor
                            : LightColors.textSecondaryColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    label: 'Search',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      'assets/images/bookmark_icon.svg',
                      colorFilter: ColorFilter.mode(
                        value.currentIndex == 2
                            ? LightColors.primaryColor
                            : LightColors.textSecondaryColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    label: 'Bookmark',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      'assets/images/profile_icon.svg',
                      colorFilter: ColorFilter.mode(
                        value.currentIndex == 3
                            ? LightColors.primaryColor
                            : LightColors.textSecondaryColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    label: 'Profile',
                  ),
                ],
              ),
              body: value.screensList[value.currentIndex],
            );
          },
        );
      },
    );
  }
}
