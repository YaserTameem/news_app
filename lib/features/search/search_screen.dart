import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/datasource/remote_data/api_service.dart';
import 'package:news_app/core/repos/news_repository.dart';
import 'package:news_app/features/details/news_details_screen.dart';
import 'package:news_app/features/home/components/news_item.dart';
import 'package:news_app/features/search/search_controller.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchScreenController(NewsRepository(ApiService())),
      child: Scaffold(
        appBar: AppBar(title: Text('Search')),
        body: Padding(
          padding: EdgeInsets.all(AppSizes.pw16),
          child: Consumer<SearchScreenController>(
            builder: (BuildContext context, SearchScreenController controller, Widget? child) {
              return Column(
                children: [
                  TextField(
                    onChanged: (value) {
                      controller.getEverything();
                    },
                    controller: controller.searchTextEditingController,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Color(0xFFA0A0A0),
                        fontWeight: FontWeight.w400,
                      ),
                      suffixIcon: Icon(
                        Icons.search_outlined,
                        size: AppSizes.r30,
                        color: Color(0xFFA0A0A0),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(color: Color(0xFFD1DAD6));
                      },
                      padding: EdgeInsets.symmetric(vertical: AppSizes.ph20),
                      itemCount: controller.newsEverythingList.length,
                      itemBuilder: (context, index) {
                        final model = controller.newsEverythingList[index];
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: AppSizes.pw16),
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => NewsDetailsScreen(model: model)),
                              );
                            },
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(
                              Icons.search_outlined,
                              size: AppSizes.r20,
                              color: Color(0xFFA0A0A0),
                            ),
                            title: Text(
                              model.title,
                              maxLines: 1,
                              style: TextStyle(overflow: TextOverflow.ellipsis),
                            ),
                            titleTextStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF6D6D6D),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
