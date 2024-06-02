import 'package:flutter/material.dart';
import 'package:travel/widgets/app_bar/custom_app_bar.dart';

import '../../core/app_export.dart';
import '../../data/data_manager.dart';
import '../../data/models/news_model/news_model.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});
  static Widget builder(BuildContext context) {
    return NewsPage();
  }

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<NewsModel> newsModelList = [];

  @override
  void initState() {
    // TODO: implement initState
    newsModelList = DataManager.getAllNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      // extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        height: 10.v,
        leadingWidth: 100.h,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'News',
              style: theme.textTheme.headlineLarge,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: newsModelList.length,
                  itemBuilder: (context, index) {
                    return _newsItemBuild(
                      context,
                      newsModelList[index],
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 60.v,
            )
          ],
        ),
      ),
    );
  }

  Widget _newsItemBuild(BuildContext context, NewsModel newsModel) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 8.v,
      ),
      decoration: AppDecoration.surface2.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () {
            NavigatorService.pushNamed(AppRoutes.newsInfoScreen,
                arguments: newsModel);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 4.v, horizontal: 6.v),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomImageView(
                  imagePath: newsModel.imgUrl,
                  height: 98.adaptSize,
                  width: 98.adaptSize,
                  fit: BoxFit.cover,
                  radius: BorderRadius.circular(
                    8.h,
                  ),
                  margin:
                      EdgeInsets.symmetric(vertical: 10.v, horizontal: 10.h),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 3.v, left: 10.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          child: Text(newsModel.title!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.titleMedium),
                        ),
                        SizedBox(
                          height: 10.v,
                        ),
                        SizedBox(
                          child: Text(newsModel.body!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodyMedium),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
