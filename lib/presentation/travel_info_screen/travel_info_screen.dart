import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel/core/app_export.dart';
import 'package:travel/data/models/travel_model/travel_model.dart';
import 'package:travel/widgets/app_bar/custom_app_bar.dart';

import '../../data/data_manager.dart';

class TravelInfoScreen extends StatelessWidget {
  final TravelModel travelModel;

  const TravelInfoScreen({super.key, required this.travelModel});

  static Widget builder(BuildContext context, TravelModel travelModel) {
    return TravelInfoScreen(travelModel: travelModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
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
        actions: [
          IconButton(
              onPressed: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (BuildContext context) {
                    return Theme(
                      data: ThemeData.dark(),
                      child: CupertinoActionSheet(
                        actions: [
                          CupertinoActionSheetAction(
                            onPressed: () {
                              NavigatorService.pushNamed(
                                  AppRoutes.travelAddScreen,
                                  arguments: travelModel);
                            },
                            child: Text(
                              'Edit',
                              style: theme.textTheme.titleMedium,
                            ),
                          ),
                          CupertinoActionSheetAction(
                            onPressed: () async {
                              await DataManager.removeTravelFromList(travelModel);
                              NavigatorService.pushNamedAndRemoveUntil(AppRoutes.navigationBarScreen);
                            },
                            child: Text(
                              'Delete',
                              style: theme.textTheme.titleMedium
                                  ?.copyWith(color: Colors.red),
                            ),
                          ),
                          // Add more actions as needed
                        ],
                      ),
                    );
                  },
                );

              },
              icon: CustomImageView(
                imagePath: ImageConstant.imgMoreVertical,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Movie info',
              style: theme.textTheme.headlineLarge,
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 20.v,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 8.v,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 16.h,
                vertical: 13.v,
              ),
              decoration: AppDecoration.surface2.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder8,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 2.v,
                      bottom: 1.v,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _textWithIcon(
                            imagePath: ImageConstant.imgMappin,
                            text: travelModel.countryName),
                        SizedBox(height: 16.v),
                        Opacity(
                          opacity: 0.5,
                          child: Text(
                            'Travel start date',
                            style: CustomTextStyles.bodyLargeInterLightgreen50,
                          ),
                        ),
                        SizedBox(height: 2.v),
                        Text(
                          DateFormat('dd/MM/yy').format(travelModel.startDate),
                          style: CustomTextStyles.bodyLargeInterPrimary,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 2.v),
                    child: Opacity(
                      opacity: 0.5,
                      child: Text(
                        _travelStateToString(travelModel.travelType),
                        style: CustomTextStyles.bodyLargeLightgreen50,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 8.v,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 16.h,
                vertical: 13.v,
              ),
              decoration: AppDecoration.surface2.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder8,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _textWithIcon(
                          imagePath: ImageConstant.imgTruck,
                          text: travelModel.transport),
                      SizedBox(
                        height: 16.v,
                      ),
                      _textWithIcon(
                          imagePath: ImageConstant.imgUser,
                          text: travelModel.companion),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Travel budget',
                        style: CustomTextStyles.bodyLargeInterLightgreen50,
                      ),
                      Text(
                        '${travelModel.travelBudget}\$',
                        style: CustomTextStyles.bodyLargeInterPrimary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8.v,
            ),
            Text(
              'Comment',
              style: theme.textTheme.titleLarge,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 8.v,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 16.h,
                vertical: 13.v,
              ),
              decoration: AppDecoration.surface2.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder8,
              ),
              child: Text(
                travelModel.comment,
                style: theme.textTheme.bodyLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textWithIcon({String imagePath = '', String text = ''}) {
    return Row(
      children: [
        CustomImageView(
          imagePath: imagePath,
          height: 24.adaptSize,
          width: 24.adaptSize,
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 8.h,
          ),
          child: Text(
            text,
            style: theme.textTheme.bodyLarge,
          ),
        )
      ],
    );
  }

  String _travelStateToString(TravelType travelType) {
    switch (travelType) {
      case TravelType.Vacation:
        return 'Vacation';
      case TravelType.Work:
        return 'Work';
      case TravelType.Other:
        return 'Other';
    }
  }
}
