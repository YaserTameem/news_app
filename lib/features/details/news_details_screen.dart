import 'dart:math';

import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/extensions/date_time_extension.dart';
import 'package:news_app/core/theme/light_colors.dart';
import 'package:news_app/core/widgets/bookmark_button.dart';
import 'package:news_app/core/widgets/custom_cached_network_image.dart';
import 'package:news_app/features/home/models/news_articles_model.dart';

class NewsDetailsScreen extends StatelessWidget {
  const NewsDetailsScreen({super.key, required this.model});

  final NewsArticlesModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('News Details')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.pw16, vertical: AppSizes.ph20),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.r4),
                child: CustomCachedNetworkImage(
                  imageUrl: model.urlToImage,
                  height: AppSizes.h228,
                  width: double.infinity,
                ),
              ),
              SizedBox(height: AppSizes.ph12),
              Text(
                model.title,
                style: TextStyle(
                  fontSize: AppSizes.sp20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF141414),
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              SizedBox(height: AppSizes.ph8),
              Row(
                children: [
                  CircleAvatar(
                    radius: AppSizes.r16,
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
                            fontSize: AppSizes.sp14,
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
                        BookmarkButton(article: model, size: 24),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppSizes.ph12),
              Text(
                model.description,
                style: TextStyle(
                  fontSize: AppSizes.sp16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF363636),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
