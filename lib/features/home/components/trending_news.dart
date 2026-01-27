import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/enums/request_status_enum.dart';
import 'package:news_app/core/extensions/date_time_extension.dart';
import 'package:news_app/core/theme/light_colors.dart';
import 'package:news_app/core/widgets/custom_cached_network_image.dart';
import 'package:news_app/features/details/news_details_screen.dart';
import 'package:news_app/features/home/categories_screen.dart';
import 'package:news_app/features/home/components/trending_news_shimmer.dart';
import 'package:news_app/features/home/components/view_all_component.dart';
import 'package:news_app/features/home/home_controller.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class TrendingNews extends StatelessWidget {
  const TrendingNews({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: AppSizes.h337,
        child: Stack(
          children: [
            SizedBox(
              height: AppSizes.h240,
              width: double.infinity,
              child: Image.asset('assets/images/background.png', fit: BoxFit.cover),
            ),
            Positioned.fill(
              top: AppSizes.h70,
              child: Column(
                children: [
                  Text(
                    "NEWST",
                    style: TextStyle(
                      color: LightColors.primaryColor,
                      fontSize: AppSizes.sp40,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: AppSizes.ph6),
                  ViewAllComponent(title: 'Trending News', onTap: () {}),
                  SizedBox(height: AppSizes.ph12),

                  SizedBox(
                    height: AppSizes.h140,
                    child: Consumer<HomeController>(
                      builder: (BuildContext context, HomeController value, Widget? child) {
                        switch (value.everythingStatus) {
                          case RequestStatusEnum.loading:
                            return TrendingNewsShimmer();
                          case RequestStatusEnum.error:
                            return Center(child: Text(value.errorMessage!));
                          case RequestStatusEnum.loaded:
                            return ListView.separated(
                              padding: EdgeInsets.only(left: AppSizes.pw16),
                              separatorBuilder:
                                  (BuildContext context, int index) => SizedBox(width: AppSizes.w12),
                              scrollDirection: Axis.horizontal,
                              itemCount: value.newsEverythingList.take(5).length,
                              itemBuilder: (context, index) {
                                final model = value.newsEverythingList[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => NewsDetailsScreen(model: model),
                                      ),
                                    );
                                  },
                                  child: SizedBox(
                                    width: AppSizes.w240,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(AppSizes.r16),
                                      child: Stack(
                                        children: [
                                          CustomCachedNetworkImage(
                                            imageUrl: model.urlToImage,
                                            height: AppSizes.h140,
                                            width: AppSizes.w240,
                                          ),
                                          Positioned.fill(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                    Colors.black.withValues(alpha: 0.5),
                                                    Colors.black.withValues(alpha: 0.7),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: AppSizes.h12,
                                            right: AppSizes.w12,
                                            left: AppSizes.w12,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  model.title,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: AppSizes.sp14,
                                                    color: LightColors.buttonTextColor,
                                                  ),
                                                  maxLines: 2,
                                                ),
                                                SizedBox(height: AppSizes.ph6),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Row(
                                                        children: [
                                                          CircleAvatar(
                                                            backgroundImage: NetworkImage(
                                                              model.urlToImage.toString(),
                                                            ),
                                                            radius: AppSizes.r10,
                                                          ),
                                                          SizedBox(width: AppSizes.pw4),
                                                          Expanded(
                                                            child: Text(
                                                              model.author,
                                                              style: TextStyle(
                                                                fontSize: AppSizes.sp12,
                                                                fontWeight: FontWeight.w400,
                                                                color: LightColors.buttonTextColor,
                                                              ),
                                                              maxLines: 1,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Text(
                                                      model.publishedAt.formatDateTime(),
                                                      style: TextStyle(
                                                        fontSize: AppSizes.sp14,
                                                        fontWeight: FontWeight.w400,
                                                        color: LightColors.buttonTextColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
