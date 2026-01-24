import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:shimmer/shimmer.dart';

class TrendingNewsShimmer extends StatelessWidget {
  const TrendingNewsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding:  EdgeInsets.only(left: AppSizes.pw16),
      scrollDirection: Axis.horizontal,
      itemCount: 5,
      separatorBuilder: (_, _) =>  SizedBox(width: AppSizes.pw12),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: SizedBox(
            width: AppSizes.w240,
            height: AppSizes.h140,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppSizes.r16),
              child: Stack(
                children: [
                  // Background image placeholder
                  Container(width: AppSizes.w240, height: AppSizes.h140, color: Colors.white),

                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.black.withOpacity(0.2), Colors.black.withOpacity(0.5)],
                        ),
                      ),
                    ),
                  ),

                  // Text placeholders
                  Positioned(
                    bottom: AppSizes.h12,
                    right: AppSizes.w12,
                    left: AppSizes.w12,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(height: AppSizes.h14, width: double.infinity, color: Colors.white),
                         SizedBox(height: AppSizes.ph6),
                        Container(height: AppSizes.h14, width: AppSizes.w140, color: Colors.white),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                             CircleAvatar(radius: AppSizes.r10, backgroundColor: Colors.white),
                            const SizedBox(width: 6),
                            Container(height: AppSizes.h12, width: AppSizes.w80, color: Colors.white),
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
}
