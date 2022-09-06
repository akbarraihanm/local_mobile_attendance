import 'package:flutter/material.dart';
import 'package:hash_micro_test/core/common/route.dart';
import 'package:hash_micro_test/core/config/const.dart';
import 'package:hash_micro_test/data/models/attendance_data/attendance_data.dart';
import 'package:hash_micro_test/data/models/location/location_data.dart';
import 'package:hash_micro_test/di/di_object.dart';
import 'package:hash_micro_test/presentation/splash/splash_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<LocationData>(LocationDataAdapter());
  Hive.registerAdapter<AttendanceData>(AttendanceDataAdapter());
  await Hive.openBox<LocationData>(Const.locationBox);
  await Hive.openBox<AttendanceData>(Const.attendanceBox);
  DIObject.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile Attendance',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Manrope',
        useMaterial3: true
      ),
      routes: AppRoute.routeNames(context),
      initialRoute: SplashScreen.routeName,
    );
  }
}
