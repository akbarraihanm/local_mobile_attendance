import 'package:flutter/material.dart';
import 'package:hash_micro_test/core/common/navigation.dart';
import 'package:hash_micro_test/core/config/const.dart';
import 'package:hash_micro_test/core/config/icons_string.dart';
import 'package:hash_micro_test/presentation/dashboard/dashboard_screen.dart';

class SplashScreen extends StatefulWidget {

  static const routeName = "/splash";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigation.pushReplacement(context, DashboardScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Const.mediaHeight(context),
        width: Const.mediaWidth(context),
        color: Colors.blue,
        child: Center(
          child: Image.asset(
            IconString.icAttendance,
            height: 150,
          ),
        ),
      ),
    );
  }
}
