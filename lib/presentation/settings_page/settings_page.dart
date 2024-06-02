import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:travel/presentation/travel_add_screen/travel_add_screen.dart';
import 'package:travel/widgets/app_bar/custom_app_bar.dart';
import 'package:travel/widgets/custom_elevated_button.dart';

import '../../core/app_export.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool privacyPolicy = false;

  bool toggleValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimary,
      appBar: CustomAppBar(
        height: 50.v,
      ),
      extendBody: true,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Settings',
              style: CustomTextStyles.headlineLargeGray200,
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 10.v),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.v),
              decoration: AppDecoration.surface2
                  .copyWith(borderRadius: BorderRadiusStyle.roundedBorder8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Your opinion is important!',
                    style: theme.textTheme.titleLarge,
                  ),
                  SizedBox(height: 8.v),
                  Text(
                    'We need your feedback to get better',
                    style: CustomTextStyles.bodyLargeLightgreen50,
                  ),
                  SizedBox(height: 10.v),
                  CustomElevatedButton(
                    text: 'Rate app',
                    onPressed: () {
                      InAppReview.instance
                          .openStoreListing(appStoreId: '6503667563');
                    },
                    buttonStyle: ElevatedButton.styleFrom(
                      disabledBackgroundColor:
                          theme.colorScheme.primary.withOpacity(.3),
                      // Background Color
                      disabledForegroundColor:
                          theme.colorScheme.onPrimaryContainer.withOpacity(.3),
                      //Text Color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20.v),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 30.v),
              decoration: AppDecoration.surface2
                  .copyWith(borderRadius: BorderRadiusStyle.roundedBorder8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _menuItem(context,
                      imagePath: ImageConstant.imgShield,
                      title: "Support",
                      widgetToEnd: Icon(
                        Icons.arrow_forward_ios,
                        color: appTheme.blueGray400,
                      ), onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                          builder: (BuildContext context) => const Dasdfds(
                                link: 'https://forms.gle/vd2R7sMaxxaG95bx7',
                              )),
                    );
                  }),
                ],
              ),
            ),
            SizedBox(height: 20.v),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 30.v),
              decoration: AppDecoration.surface2
                  .copyWith(borderRadius: BorderRadiusStyle.roundedBorder8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _menuItem(context,
                      imagePath: ImageConstant.imgDoc,
                      title: "Privacy policy",
                      widgetToEnd: Icon(
                        Icons.arrow_forward_ios,
                        color: appTheme.blueGray400,
                      ),
                      onTap: () => {
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      const Dasdfds(
                                        link:
                                            'https://docs.google.com/document/d/1VMnusI-TR8kQLOJco18ejytDl1jd7tgdzUBznso_XJ4/edit?usp=sharing',
                                      )),
                            )
                          }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuItem(BuildContext context,
      {String imagePath = '',
      String title = '',
      Function? onTap,
      Widget? widgetToEnd}) {
    return InkWell(
      onTap: () => {onTap?.call()},
      child: Row(children: [
        CustomImageView(
            imagePath: imagePath, height: 24.adaptSize, width: 24.adaptSize),
        Expanded(
          child: Padding(
              padding: EdgeInsets.only(left: 15.h, top: 2.v),
              child: Text(title, style: theme.textTheme.bodyLarge)),
        ),
        widgetToEnd ?? Container(),
      ]),
    );
  }
}
