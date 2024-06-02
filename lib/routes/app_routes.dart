import 'package:flutter/material.dart';
import 'package:travel/data/models/news_model/news_model.dart';
import 'package:travel/data/models/travel_model/travel_model.dart';
import 'package:travel/presentation/history_screen/history_screen.dart';
import 'package:travel/presentation/navigation_bar_screen/navigation_bar_screen.dart';
import 'package:travel/presentation/news_info_screen/news_info_screen.dart';
import 'package:travel/presentation/travel_add_screen/travel_add_screen.dart';
import 'package:travel/presentation/travel_info_screen/travel_info_screen.dart';

import '../presentation/onboarding_screen/onboarding_screen.dart';

class AppRoutes {
  static const String onboardingScreen = '/onboarding_screen';

  static const String travelAddScreen = '/item_add_screen';

  static const String travelInfoScreen = '/item_info_screen';
  static const String historyScreen = '/history_screen';
  static const String newsInfoScreen = '/news_info_screen';

  static const String homePage = '/home_page';

  static const String settingsPage = '/settings_page';

  static const String newsPage = '/news_page';

  static const String navigationBarScreen = '/navigation_bar_screen';

  static Map<String, WidgetBuilder> get routes => {
        onboardingScreen: OnboardingScreen.builder,
        navigationBarScreen: NavigationBarScreen.builder,

        travelAddScreen: (context) {
          dynamic arguments = null;
          if (ModalRoute.of(context)?.settings.arguments is TravelModel) {
            arguments =
                (ModalRoute.of(context)?.settings.arguments as TravelModel);
          }
          return TravelAddScreen.builder(context, arguments);
        },

        historyScreen: (context) {
          dynamic arguments = null;

          arguments =
              (ModalRoute.of(context)?.settings.arguments as List<TravelModel>);

          return HistoryScreen.builder(context, arguments);
        },
        travelInfoScreen: (context) {
          final arguments =
              ModalRoute.of(context)!.settings.arguments as TravelModel;
          return TravelInfoScreen.builder(context, arguments);
        },
    newsInfoScreen: (context) {
      final arguments =
      ModalRoute.of(context)!.settings.arguments as NewsModel;
      return NewsInfoScreen.builder(context, arguments);
    },
        // settingsScreen: SettingsScreen.builder,
      };
}
