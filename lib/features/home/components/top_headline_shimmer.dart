import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:shimmer/shimmer.dart';

class TopHeadlineShimmer extends StatelessWidget {
  const TopHeadlineShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.pw16, vertical: AppSizes.ph12),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Row(
              children: [
                // Image placeholder
                Container(
                  width: AppSizes.w90,
                  height: AppSizes.h70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppSizes.r8),
                  ),
                ),
                SizedBox(width: AppSizes.pw8),

                // Text placeholders
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(height: AppSizes.h16, width: double.infinity, color: Colors.white),
                      SizedBox(height: AppSizes.ph8),
                      Container(
                        height: AppSizes.h14,
                        width: MediaQuery.of(context).size.width * 0.4,
                        color: Colors.white,
                      ),
                      SizedBox(height: AppSizes.ph12),
                      Row(
                        children: [
                          CircleAvatar(radius: AppSizes.r10, backgroundColor: Colors.white),
                          SizedBox(width: AppSizes.pw6),
                          Container(height: AppSizes.h12, width: AppSizes.w80, color: Colors.white),
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
}
