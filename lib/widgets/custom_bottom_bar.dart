import 'package:flutter/material.dart';

import '../core/app_export.dart';

class CustomBottomBar extends StatefulWidget {
  CustomBottomBar({this.onChanged});

  Function(BottomBarEnum)? onChanged;

  @override
  CustomBottomBarState createState() => CustomBottomBarState();
}

class CustomBottomBarState extends State<CustomBottomBar> {
  int selectedIndex = 0;

  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      icon: ImageConstant.imgHomeDisable,
      activeIcon: ImageConstant.imgHomeEnabled,
      type: BottomBarEnum.Home,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgNewsDisabled,
      activeIcon: ImageConstant.imgNewsEnabled,
      type: BottomBarEnum.News,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgSettingsDisabled,
      activeIcon: ImageConstant.imgSettingsEnabled,
      type: BottomBarEnum.Settings,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 74.v,
      decoration: BoxDecoration(
        color: theme.colorScheme.background,
        // boxShadow: [
        // BoxShadow(
        //   // color: Colors.black,s
        //   //spreadRadius: 5.h,
        //   // blurRadius: 5.h,
        // ),
        // ],
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        showSelectedLabels: false,
        elevation: 0.0,
        showUnselectedLabels: false,
        selectedFontSize: 0,
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: List.generate(bottomMenuList.length, (index) {
          return BottomNavigationBarItem(
            icon: CustomImageView(
              imagePath: bottomMenuList[index].icon,
              height: 24.adaptSize,
              width: 24.adaptSize,
              color: appTheme.blueGray700,
            ),
            activeIcon: CustomImageView(
              imagePath: bottomMenuList[index].activeIcon,
              height: 24.adaptSize,
              width: 24.adaptSize,
              color: theme.colorScheme.primaryContainer,
            ),
            label: '',
          );
        }),
        onTap: (index) {
          selectedIndex = index;
          widget.onChanged?.call(bottomMenuList[index].type);
          setState(() {});
        },
      ),
    );
  }
}

enum BottomBarEnum { Home, News, Settings }

class BottomMenuModel {
  BottomMenuModel({
    required this.icon,
    required this.activeIcon,
    required this.type,
  });

  String icon;

  String activeIcon;

  BottomBarEnum type;
}

class DefaultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please replace the respective Widget here',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
