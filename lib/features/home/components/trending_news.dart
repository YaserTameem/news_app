import 'package:flutter/material.dart';
import 'package:news_app/core/enums/request_status_enum.dart';
import 'package:news_app/core/theme/light_colors.dart';
import 'package:news_app/features/home/components/view_all_component.dart';
import 'package:news_app/features/home/home_controller.dart';
import 'package:provider/provider.dart';

class TrendingNews extends StatelessWidget {
  const TrendingNews({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 337,
      child: Stack(
        children: [
          SizedBox(
            height: 240,
            width: double.infinity,
            child: Image.asset('assets/images/background.png', fit: BoxFit.cover),
          ),
          Positioned.fill(
            top: 70,
            child: Column(
              children: [
                Text(
                  "NEWST",
                  style: TextStyle(
                    color: LightColors.primaryColor,
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 6),
                ViewAllComponent(title: 'Trending News',onTap: (){},),
                SizedBox(height: 12),

                SizedBox(
                  height: 140,
                  child: Consumer<HomeController>(
                    builder: (BuildContext context, HomeController value, Widget? child) {
                      switch (value.everythingStatus) {
                        case RequestStatusEnum.loading:
                          return Center(child: CircularProgressIndicator());
                        case RequestStatusEnum.error:
                          return Center(child: Text(value.errorMessage!));
                        case RequestStatusEnum.loaded:
                          return ListView.separated(
                            padding: EdgeInsets.only(left: 16),
                            separatorBuilder: (BuildContext context, int index) => SizedBox(width: 12),
                            scrollDirection: Axis.horizontal,
                            itemCount: value.newsEverythingList.take(5).length,
                            itemBuilder: (context, index) {
                              final model = value.newsEverythingList[index];
                              return SizedBox(
                                width: 240,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Stack(
                                    children: [
                                      Image.network(height: 140, width: 240, model.urlToImage),
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
                                        bottom: 12,
                                        right: 12,
                                        left: 12,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              model.title,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: LightColors.buttonTextColor,
                                              ),
                                              maxLines: 2,
                                            ),
                                            SizedBox(height: 6),
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
                                                        radius: 10,
                                                      ),
                                                      SizedBox(width: 4),
                                                      Expanded(
                                                        child: Text(
                                                          model.author,
                                                          style: TextStyle(
                                                            fontSize: 12,
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
                                                  formateDateTime(model.publishedAt),
                                                  style: TextStyle(
                                                    fontSize: 14,
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
    );
  }

  String formateDateTime(String? date) {
    if (date == null) return "";
    final diff = DateTime.now().difference(DateTime.parse(date));
    if (diff.inMinutes < 60) {
      return "${diff.inMinutes}m ago";
    }
    if (diff.inHours < 24) {
      return "${diff.inHours}hours ago";
    }
    return "${diff.inDays} day ago";
  }
}
