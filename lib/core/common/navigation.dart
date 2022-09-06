import 'package:flutter/material.dart';

class Navigation {
  static Future pushData(BuildContext context,
      {String? routeName, Object? arguments}) {
    return Navigator.pushNamed(context, routeName!, arguments: arguments);
  }

  static Future push(BuildContext context, String routeName) {
    return Navigator.pushNamed(context, routeName);
  }

  static Future pushReplacement(BuildContext context, String routeName, {dynamic arguments}) {
    return Navigator.pushReplacementNamed(context, routeName, arguments: arguments);
  }

  static pushAndRemoveAll(BuildContext context, String routeName) {
    Navigator.pushNamedAndRemoveUntil(context,
      routeName,
          (Route<dynamic> route) => false,
    );
  }

  static pushAndRemoveUntilMain(BuildContext context, String routeName) {
    Navigator.pushNamedAndRemoveUntil(context,
      routeName,
      ModalRoute.withName("/home"),
    );
  }

  static popUntil(BuildContext context, String routeName) {
    Navigator.popUntil(context, ModalRoute.withName(routeName));
  }

  static pop(BuildContext context, {dynamic values}) => Navigator.pop(context, values);

}