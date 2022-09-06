import 'package:flutter/material.dart';
import 'package:hash_micro_test/presentation/checkpoint/pin_location/pin_location_screen.dart';
import 'package:hash_micro_test/presentation/dashboard/dashboard_screen.dart';
import 'package:hash_micro_test/presentation/splash/splash_screen.dart';

class AppRoute {
  static Map<String, WidgetBuilder> routeNames(BuildContext context) {
    return {
      SplashScreen.routeName: (context) => const SplashScreen(),
      DashboardScreen.routeName: (context) => const DashboardScreen(),
      PinLocationScreen.routeName: (context) => const PinLocationScreen(),
    };
  }
}