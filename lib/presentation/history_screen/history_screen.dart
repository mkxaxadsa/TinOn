import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/app_export.dart';
import '../../data/models/travel_model/travel_model.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';

class HistoryScreen extends StatelessWidget {
  final List<TravelModel> travelsList;

  const HistoryScreen({super.key, required this.travelsList});

  static Widget builder(BuildContext context, List<TravelModel> travels) {
    return HistoryScreen(
      travelsList: travels,
    );
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
                  style: CustomTextStyles.bodyLargeInterPrimary,
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
        padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 12.v),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'History',
              style: theme.textTheme.headlineLarge,
            ),
            SizedBox(
              height: 20.v,
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: travelsList.length,
                itemBuilder: (context, index) {
                  return _itemWidget(
                    context,
                    travelsList[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemWidget(BuildContext context, TravelModel travelModel) {
    return Container(
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
                Row(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgMappin,
                      height: 24.adaptSize,
                      width: 24.adaptSize,
                      margin: EdgeInsets.only(bottom: 3.v),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 8.h,
                        top: 2.v,
                      ),
                      child: Text(
                        travelModel.countryName!,
                        style: theme.textTheme.bodyLarge,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 14.v),
                Opacity(
                  opacity: 0.5,
                  child: Text(
                    'Travel start date',
                    style: CustomTextStyles.bodyLargeLightgreen50,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomElevatedButton(
                    onPressed: () {
                      NavigatorService.pushNamed(AppRoutes.travelInfoScreen,
                          arguments: travelModel);
                    },
                    width: 100.h,
                    height: 30.v,
                    text: 'More info'),
                SizedBox(height: 37.v),
                Opacity(
                  opacity: 0.5,
                  child: Text(
                    _travelStateToString(travelModel.travelType),
                    style: CustomTextStyles.bodyLargeLightgreen50,
                  ),
                )
              ],
            ),
          )
        ],
      ),
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
