import 'dart:math';

import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/extensions/date_time_extension.dart';
import 'package:news_app/core/theme/light_colors.dart';
import 'package:news_app/core/widgets/custom_cached_network_image.dart';
import 'package:news_app/core/widgets/custom_svg_picture.dart';
import 'package:news_app/features/details/news_details_screen.dart';
import 'package:news_app/features/home/models/news_articles_model.dart';

class NewsItem extends StatelessWidget {
  const NewsItem({super.key, required this.model});

  final NewsArticlesModel model;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NewsDetailsScreen(model: model)),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.pw16, vertical: AppSizes.ph12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSizes.r8),
              child: CustomCachedNetworkImage(imageUrl: model.urlToImage),
            ),
            SizedBox(width: AppSizes.pw8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    model.title,
                    style: TextStyle(
                      fontSize: AppSizes.sp16,
                      fontWeight: FontWeight.w400,
                      color: LightColors.textPrimaryColor,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 2,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: AppSizes.r10,
                        backgroundImage:
                            model.urlToImage.isNotEmpty
                                ? NetworkImage(model.urlToImage)
                                : AssetImage('assets/images/placeholder.png') as ImageProvider,
                      ),
                      SizedBox(width: AppSizes.pw4),
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              model.author.substring(0, min(model.author.length, 10)),
                              style: TextStyle(
                                fontSize: AppSizes.sp12,
                                fontWeight: FontWeight.w400,
                                color: LightColors.textPrimaryColor,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(width: AppSizes.pw8),
                            Expanded(
                              child: Text(
                                model.publishedAt.formatDateTime(),
                                style: TextStyle(
                                  fontSize: AppSizes.sp12,
                                  fontWeight: FontWeight.w400,
                                  color: LightColors.textPrimaryColor,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            CustomSvgPicture.withoutColor(path: 'assets/images/bookmark.svg'),
                          ],
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
  }
}
