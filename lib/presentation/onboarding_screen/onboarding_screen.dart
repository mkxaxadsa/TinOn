import 'package:flutter/material.dart';
import 'package:travel/widgets/custom_elevated_button.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_text_form_field.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  static Widget builder(BuildContext context) {
    return OnboardingScreen();
  }

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  bool isOptionChoose = false;
  TextEditingController _textFieldController = TextEditingController();
  PageController _pageController = PageController();
  bool _isDisabled = false;

  @override
  void initState() {
    super.initState();
    _textFieldController.addListener(_updateTextFieldValue);

    _pageController.addListener(() {
      if (_pageController.page == 2) {
        setState(() {
          _isDisabled = true;
        });
      } else {
        setState(() {
          _isDisabled = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.blueGray900,
      body: PageView.custom(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        childrenDelegate: SliverChildListDelegate(
          [firstScreen(context), secondScreen(context), thirdScreen(context)],
        ),
      ),
      floatingActionButton: CustomElevatedButton(
        isDisabled: (!isTextFieldFilled() || !isOptionChoose) && _isDisabled,
        text: 'Continue',
        buttonStyle: ElevatedButton.styleFrom(
          disabledBackgroundColor:
              theme.colorScheme.primary.withOpacity(.3), // Background Color
          disabledForegroundColor:
              theme.colorScheme.onPrimaryContainer.withOpacity(.3), //Text Color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                40.0), // Устанавливаем радиус скругления углов
          ),
        ),
        margin: EdgeInsets.only(
          left: 16.h,
          right: 16.h,
        ),
        onPressed: () {
          if (_pageController.page == 2) {
            NavigatorService.pushNamedAndRemoveUntil(
                AppRoutes.navigationBarScreen);
          } else {
            _pageController.nextPage(
                duration: Duration(milliseconds: 100), curve: Curves.linear);
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget firstScreen(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomImageView(
            height: 300.adaptSize,
            imagePath: ImageConstant.img272576667270443,
            fit: BoxFit.fitHeight,
          ),
          SizedBox(
            height: 50.v,
          ),
          Text(
            'Welcome to our\napp!',
            style: CustomTextStyles.headlineLargeGray200,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 16.v,
          ),
          Text(
            'Plan and track trips to different countries',
            style: CustomTextStyles.bodyLargeInterLightgreen50,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  Widget secondScreen(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomImageView(
            height: 300.adaptSize,
            imagePath: ImageConstant.img346811048202653,
            fit: BoxFit.fitHeight,
          ),
          SizedBox(
            height: 50.v,
          ),
          Text(
            'Track your\ntravels!',
            style: CustomTextStyles.headlineLargeGray200,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 16.v,
          ),
          Text(
            'See the stories of your travels',
            style: CustomTextStyles.bodyLargeInterLightgreen50,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  bool isTextFieldFilled() {
    setState(() {});
    return _textFieldController.text.isNotEmpty;
  }

  String _textFieldValue = '';

  void _updateTextFieldValue() {
    setState(() {
      _textFieldValue = _textFieldController.text;
    });
  }

  List options = [
    {'title': '1-2', 'isActive': false},
    {'title': '3-5', 'isActive': false},
    {'title': 'More than 5', 'isActive': false},
  ];

  Widget thirdScreen(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 80.v,
              ),
              Text(
                'Let’s get acquainted',
                style: theme.textTheme.headlineLarge,
              ),
              SizedBox(
                height: 25.v,
              ),
              CustomTextFormField(
                controller: _textFieldController,
                textStyle: theme.textTheme.bodyLarge,
                hintText: 'Write your name',
                hintStyle: CustomTextStyles.bodyLargeLightgreen50,
              ),
              SizedBox(
                height: 16.v,
              ),
              _buildChooser(context),
              SizedBox(
                height: 16.v,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChooser(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'How many countries you visit in a year?',
            style: CustomTextStyles.bodyLargeLightgreen50,
          ),
        ),
        SizedBox(
          height: 4.v,
        ),
        Column(
          children: options
              .map(
                (option) => Container(
                  margin: EdgeInsets.symmetric(vertical: 8.v),
                  height: 52.v,
                  //width: double.infinity,
                  decoration: customBoxDecoration(option['isActive']),
                  child: InkWell(
                    onTap: () {
                      changeState(option);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.h),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${option['title']}',
                          textAlign: TextAlign.start,
                          style: option['isActive']
                              ? theme.textTheme.bodyLarge
                              : theme.textTheme.bodyLarge,
                        ),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  changeState(option) {
    setState(() {
      for (var item in options) {
        if (item == option) {
          isOptionChoose = true;
          item['isActive'] = true;
        } else {
          item['isActive'] = false;
        }
      }
    });
  }

  customBoxDecoration(isActive) {
    return BoxDecoration(
      color: isActive ? appTheme.blueGray700 : appTheme.blueGray700,
      border: isActive
          ? Border.all(color: theme.colorScheme.primary)
          : Border.all(color: appTheme.blueGray700),
      borderRadius: const BorderRadius.all(
        Radius.circular(8.0),
      ),
    );
  }
}
