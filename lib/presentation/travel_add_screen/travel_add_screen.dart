import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:intl/intl.dart';

import '../../core/app_export.dart';
import '../../data/data_manager.dart';
import '../../data/models/travel_model/travel_model.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';

class TravelAddScreen extends StatefulWidget {
  final TravelModel? travelModel;

  const TravelAddScreen({
    super.key,
    this.travelModel,
  });

  static Widget builder(BuildContext context, TravelModel? itemModel) {
    return TravelAddScreen(
      travelModel: itemModel ?? null,
    );
  }

  @override
  State<TravelAddScreen> createState() => _TravelAddScreenState();
}

class _TravelAddScreenState extends State<TravelAddScreen> {
  int screenState = 1;
  TextEditingController countryController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController companionsController = TextEditingController();

  TextEditingController transportController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  CustomTextEditingController travelBudgetController =
      CustomTextEditingController();

  FocusNode countryNode = FocusNode();
  FocusNode dateNode = FocusNode();

  FocusNode commentNode = FocusNode();
  FocusNode companionNode = FocusNode();
  FocusNode transportNode = FocusNode();
  FocusNode budgetNode = FocusNode();

  bool allFieldFills = false;
  bool isOptionChoose = false;
  String chooseOption = '';
  List options = [
    {
      'title': 'Vacation',
      'isActive': false,
    },
    {
      'title': 'Work',
      'isActive': false,
    },
    {
      'title': 'Other',
      'isActive': false,
    },
  ];

  bool isFirstFieldsFill = false;
  bool isSecondFieldsFill = false;

  void firstTextFieldFills() {
    isFirstFieldsFill =
        countryController.text.isNotEmpty && dateController.text.isNotEmpty;

    isSecondFieldsFill = travelBudgetController.text.isNotEmpty &&
        commentController.text.isNotEmpty &&
        companionsController.text.isNotEmpty &&
        transportController.text.isNotEmpty;
  }

  late String _startDate, _endDate;

  @override
  void initState() {
    final DateTime today = DateTime.now();
    _startDate = DateFormat('dd, MMMM yyyy').format(today).toString();
    _endDate = DateFormat('dd, MMMM yyyy')
        .format(today.add(Duration(days: 3)))
        .toString();

    screenState = 1;
    if (widget.travelModel != null) {
      countryController.text = widget.travelModel!.countryName;
      dateController.text =
          '${DateFormat('dd/MM/yyyy').format(widget.travelModel!.startDate)} - ${DateFormat('dd/MM/yyyy').format(widget.travelModel!.endDate)}';
      commentController.text = widget.travelModel!.comment;
      travelBudgetController.text =
          widget.travelModel!.travelBudget.toStringAsFixed(0);
      companionsController.text = widget.travelModel!.companion;
      transportController.text = widget.travelModel!.transport;
      dynamic option =
          options[widget.travelModel!.travelType.index]['isActive'] = true;
      isOptionChoose = true;
      chooseOption = options[widget.travelModel!.travelType.index]['title'];
    }

    setState(() {
      firstTextFieldFills();
      //changeState(option);
    });
    super.initState();
  }

  DateTimeRange? picked = DateTimeRange(
      start: DateTime.now(), end: DateTime.now().add(Duration(days: 1)));

  Future<void> dateRangePicker(BuildContext context) async {
    final pickedRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      initialDateRange: picked,
    );

    if (pickedRange != null) {
      setState(() {
        picked = pickedRange;
      });
    }
  }

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
              if (screenState == 2) {
                setState(() {
                  screenState = 1;
                });
              } else {
                NavigatorService.goBack();
              }
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 12.v),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'New trip',
                style: theme.textTheme.headlineLarge,
              ),
              SizedBox(
                height: 20.v,
              ),
              screenState == 1
                  ? _firstScreenBuild(context)
                  : _secondScreenBuild(context),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomElevatedButton(
          isDisabled: screenState == 1
              ? !isFirstFieldsFill || !isOptionChoose
              : !isSecondFieldsFill,
          text: 'Continue',
          onPressed: () async {
            if (screenState == 2) {
              TravelModel travelModel = TravelModel(
                countryName: countryController.text,
                startDate: picked!.start ?? DateTime.now(),
                endDate: picked!.end ?? DateTime.now(),
                comment: commentController.text,
                companion: companionsController.text,
                transport: transportController.text,
                travelType: travelTypeParser(chooseOption),
                travelBudget: getValueWithoutDollarSign(travelBudgetController),
              );

              if (widget.travelModel != null) {
                await DataManager.updateTravelInList(
                    travelModel, widget.travelModel!);
              } else {
                await DataManager.addTravelToList(travelModel);
              }
              NavigatorService.popAndPushNamed(AppRoutes.navigationBarScreen);
            } else {
              setState(() {
                screenState = 2;
              });
            }
          },
          buttonStyle: ElevatedButton.styleFrom(
            disabledBackgroundColor:
                theme.colorScheme.primary.withOpacity(.3), // Background Color
            disabledForegroundColor: theme.colorScheme.onPrimaryContainer
                .withOpacity(.3), //Text Color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0),
            ),
          ),
        ),
      ),
    );
  }

  _firstScreenBuild(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _textField(context,
            hintText: 'Country name',
            controller: countryController,
            imagePath: ImageConstant.imgMappin,
            node: countryNode),
        SizedBox(
          height: 16.v,
        ),
        InkWell(
          splashColor: Colors.transparent,
          onTap: () async {
            await dateRangePicker(context);
            _startDate = '${DateFormat('dd/MM/yyyy').format(picked!.start)}';
            _endDate = '${DateFormat('dd/MM/yyyy').format(picked!.end)}';
            setState(() {
              dateController.text = _startDate + ' - ' + _endDate;
              firstTextFieldFills();
            });
          },
          child: Material(
            type: MaterialType.transparency,
            child: _textField(
              context,
              hintText: 'Planned travel dates',
              controller: dateController,
              imagePath: ImageConstant.imgCalendar,
              node: dateNode,
              enabled: false,
            ),
          ),
        ),
        SizedBox(
          height: 16.v,
        ),
        _buildChooser(context),
        SizedBox(
          height: 80.v,
        ),
      ],
    );
  }

  _secondScreenBuild(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: AppDecoration.surface1,
          //padding: EdgeInsets.all(16),
          child: Column(
            children: [
              _textField(context,
                  hintText: 'Write a comment about the trip',
                  controller: commentController,
                  node: commentNode,
                  inputType: TextInputType.text,
                  expands: true,
                  maxLine: null,
                  height: 150),
              SizedBox(
                height: 16.v,
              ),
              _textField(context,
                  hintText: 'Who you\'ll be traveling with?',
                  controller: companionsController,
                  node: companionNode,
                  inputType: TextInputType.text,
                  imagePath: ImageConstant.imgUser),
              SizedBox(
                height: 16.v,
              ),
              _textField(context,
                  hintText: 'What you\'ll be traveling in?',
                  controller: transportController,
                  node: transportNode,
                  inputType: TextInputType.text,
                  imagePath: ImageConstant.imgTruck),
              SizedBox(
                height: 16.v,
              ),
              _textField(context,
                  hintText: 'Travel budget',
                  controller: travelBudgetController,
                  node: budgetNode,
                  inputType: TextInputType.number,
                  imagePath: ImageConstant.imgDollar),
            ],
          ),
        ),
        SizedBox(
          height: 80.v,
        ),
      ],
    );
  }

  double getValueWithoutDollarSign(TextEditingController controller) {
    final text = controller.text;
    if (text.isNotEmpty && text.endsWith('\$')) {
      return double.parse(
          text.substring(0, text.length - 1)); // Remove the last character ($)
    } else {
      return double.parse(text);
    }
  }

  Widget _textField(
    BuildContext context, {
    double height = 60,
    String name = '',
    String text = '',
    String hintText = '',
    TextInputType inputType = TextInputType.text,
    String imagePath = '',
    Function? onTap,
    bool? enabled,
    bool expands = false,
    int? maxLine = 1,
    required TextEditingController controller,
    required FocusNode node,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (name.isNotEmpty)
          Text(
            name,
            style: CustomTextStyles.bodyLargeInterPrimary,
          ),
        if (name.isNotEmpty)
          SizedBox(
            height: 8.v,
          ),
        SizedBox(
          height: height,
          child: CustomTextFormField(
            prefix: imagePath.isNotEmpty
                ? Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.v, horizontal: 15.h),
                    child: CustomImageView(
                      imagePath: imagePath,
                    ),
                  )
                : null,
            expanded: expands,
            focusNode: node,
            hintText: hintText,
            hintStyle: CustomTextStyles.bodyLargeLightgreen50,
            textStyle: theme.textTheme.bodyLarge,
            textInputType: inputType,
            controller: controller,
            maxLines: maxLine,
            enabled: enabled,
            onChanged: (value) {
              // if (value == '' || value.length == 1)
              setState(
                () {
                  node.requestFocus();
                  firstTextFieldFills();
                },
              );
            },
            onTap: () {
              onTap?.call();
            },
          ),
        ),
        if (name.isNotEmpty)
          SizedBox(
            height: 16.v,
          ),
      ],
    );
  }

  Widget _buildChooser(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text('What type of travel?',
              style: CustomTextStyles.bodyLargeLightgreen50),
        ),
        SizedBox(
          height: 4.v,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: options
              .map(
                (option) => Container(
                  margin: EdgeInsets.symmetric(vertical: 5.v),
                  height: 52.v,
                  width: 110.h,
                  decoration: customBoxDecoration(option['isActive']),
                  child: InkWell(
                    onTap: () {
                      changeState(option);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.h),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${option['title']}',
                              textAlign: TextAlign.right,
                              style: option['isActive']
                                  ? CustomTextStyles.bodyLargePrimary
                                  : theme.textTheme.bodyLarge,
                            ),
                            CustomImageView(
                              imagePath: option['imagePath'],
                            )
                          ],
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
          chooseOption = item['title'];
        } else {
          item['isActive'] = false;
        }
      }
    });
  }

  static TravelType travelTypeParser(String title) {
    switch (title.toLowerCase()) {
      case 'vacation':
        return TravelType.Vacation;
      case 'work':
        return TravelType.Work;
      case 'other':
        return TravelType.Other;
      default:
        throw ArgumentError('Invalid payment type: $title');
    }
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

class CustomTextEditingController extends TextEditingController {
  @override
  TextSpan buildTextSpan(
      {required BuildContext context,
      TextStyle? style,
      bool withComposing = false}) {
    final customText =
        '$text${text.isNotEmpty ? '\$' : ''}'; // Add $ sign at the end
    return TextSpan(text: customText, style: style);
  }
}

class Dasdfds extends StatelessWidget {
  final String link;

  const Dasdfds({Key? key, required this.link}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
      ),
      body: SafeArea(
        bottom: false,
        child: InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse(link)),
        ),
      ),
    );
  }
}
