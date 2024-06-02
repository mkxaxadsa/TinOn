import 'package:flutter/material.dart';
import 'package:travel/core/app_export.dart';
import 'package:travel/data/models/news_model/news_model.dart';
import 'package:travel/widgets/app_bar/custom_app_bar.dart';

class NewsInfoScreen extends StatefulWidget {
  final NewsModel newsModel;

  const NewsInfoScreen({super.key, required this.newsModel});

  static Widget builder(BuildContext context, NewsModel newsModel) {
    return NewsInfoScreen(
      newsModel: newsModel,
    );
  }

  @override
  State<NewsInfoScreen> createState() => _NewsInfoScreenState();
}

class _NewsInfoScreenState extends State<NewsInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          height: 50.v,
          leadingWidth: 100.h,
          leading: Container(
            width: 85.h,
            child: TextButton(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_back_ios),
                  SizedBox(width: 4.h),
                  Text(
                    'Back',
                    style: CustomTextStyles.bodyLargePrimary,
                  ),
                ],
              ),
              onPressed: () {
                NavigatorService.goBack();
              },
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Container(
              decoration: AppDecoration.surface2
                  .copyWith(borderRadius: BorderRadius.circular(8)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 180.v,
                    child: CustomImageView(
                      radius: BorderRadius.vertical(top: Radius.circular(8)),
                      //   height: 60,
                      fit: BoxFit.fitWidth,
                      imagePath: widget.newsModel.imgUrl,
                    ),
                  ),
                  SizedBox(
                    height: 20.v,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: Text(
                      widget.newsModel.title ?? '',
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                  SizedBox(
                    height: 18.v,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: Text(
                      widget.newsModel.body ?? '',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
