import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel/data/models/travel_model/travel_model.dart';
import 'package:travel/presentation/home_page/home_bloc/home_bloc.dart';
import 'package:travel/widgets/app_bar/custom_app_bar.dart';
import 'package:travel/widgets/custom_elevated_button.dart';

import '../../core/app_export.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => HomeBloc()..add(HomeGetEvent()),
      child: HomePage(),
    );
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool historyActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        height: 50.v,
        actions: [
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoadedFullState) {
                return Container(
                  width: 100.h,
                  height: 100.v,
                  child: TextButton(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'History',
                          style: CustomTextStyles.bodyLargeInterPrimary,
                        ),
                      ],
                    ),
                    onPressed: () {
                      NavigatorService.pushNamed(AppRoutes.historyScreen,
                          arguments: state.travelModelList);
                    },
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
      //extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: theme.colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Nearby travels',
              style: CustomTextStyles.headlineLargeGray200,
              textAlign: TextAlign.left,
            ),
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeLoadedEmptyState) {
                  historyActive = false;

                  return _emptyScreenBuild(context);
                } else if (state is HomeLoadedFullState) {
                  return Expanded(child: _fullScreenBuild(context, state));
                } else {
                  return Expanded(
                      child: Center(child: CircularProgressIndicator()));
                }
              },
            ),
          ],
        ),
      ),

      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 80.v),
        child: IconButton(
          splashRadius: 30.h,
          iconSize: 50.h,
          icon: CustomImageView(
            height: 50.v,
            width: 50.h,
            imagePath: ImageConstant.imgFrame,
          ),
          onPressed: () => NavigatorService.pushNamed(AppRoutes.travelAddScreen,
              arguments: null),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }

  Widget _emptyScreenBuild(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 50.v,
            ),
            Padding(
              padding: EdgeInsets.all(5.h),
              child: CustomImageView(
                fit: BoxFit.fitHeight,
                imagePath: ImageConstant.img116379974788934,
              ),
            ),
            SizedBox(
              height: 40.v,
            ),
            Padding(
              padding: EdgeInsets.all(4.h),
              child: Column(
                children: [
                  Text(
                    'There\'s no info',
                    style: CustomTextStyles.titleLargePrimary,
                  ),
                  SizedBox(
                    height: 8.v,
                  ),
                  Text(
                    'Add your new trip',
                    textAlign: TextAlign.center,
                    style: CustomTextStyles.bodyLargeLightgreen50,
                  ),
                  SizedBox(
                    height: 8.v,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 80.h, top: 20.v),
                    child: CustomImageView(
                      //width: 100,
                      fit: BoxFit.fitWidth,
                      imagePath: ImageConstant.imgVector1,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _fullScreenBuild(BuildContext context, HomeLoadedFullState state) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 12.v),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 115.v,
            padding: EdgeInsets.all(16.h),
            decoration: AppDecoration.surface2
                .copyWith(borderRadius: BorderRadius.circular(8)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'My total travels',
                      style: theme.textTheme.titleLarge,
                    ),
                    Text(
                      state.travelModelList.length.toString(),
                      style: CustomTextStyles.titleLargePrimary,
                    )
                  ],
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgPalm,
                  fit: BoxFit.fitHeight,
                )
              ],
            ),
          ),
          SizedBox(
            height: 16.v,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.nearestThreeTravels.length,
                  itemBuilder: (context, index) {
                    return _itemWidget(
                      context,
                      state.nearestThreeTravels[index],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
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
                  onPressed: (){NavigatorService.pushNamed(AppRoutes.travelInfoScreen, arguments: travelModel);},
                    width: 100.h, height: 30.v, text: 'More info'),
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
