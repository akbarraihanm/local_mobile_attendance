import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../presentation/widgets/app_text.dart';
import '../common/datetime_formatter.dart';
import '../config/app_typography.dart';

class AppUtil {
  static String convertDateTime(String dt) {
    var date = DateTimeFormatter.formatTime(
        dateFormat: "dd MMMM yyyy", dateTime: DateTime.parse(dt)
    );
    var hours = DateTimeFormatter.formatTime(
        dateFormat: "HH:mm", dateTime: DateTime.parse(dt)
    );
    return "$date at $hours";
  }

  static void showSnackBar(BuildContext context,
      {String? message, bool isError = true}) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: AppText(
        title: message,
        textStyle: AppTypography.body2(color: Colors.white),
      ),
      backgroundColor: isError ? Colors.red : Colors.black,
      behavior: SnackBarBehavior.floating,
    ));
  }

  static Future showBottomSheet(BuildContext context, {Widget? child}) async {

    return showModalBottomSheet(
        context: context,
        enableDrag: true,
        isDismissible: true,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (ctx) => Material(
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(16),
              topLeft: Radius.circular(16)
          ),
          child: child,
        )
    );
  }

  static Future<String> getAddress(dynamic latitude, dynamic longitude) async{
    String address = "";
    try {
      var placeMarks = await placemarkFromCoordinates(latitude, longitude, localeIdentifier: 'id_ID');
      if (placeMarks.first.locality != "" || placeMarks.first.subLocality != "") {
        address = "${placeMarks.first.street == ""? "": placeMarks.first.street}, "
            "${placeMarks.first.subLocality}${placeMarks.first.locality !=
            ""? ", ${placeMarks.first.locality}": ""}";
      } else {
        address = "Unidentified";
      }
    } catch (ex) {
      return "";
    }
    return address;
  }

  static Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: "Location services are disabled");
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: "Location permissions are denied");
        await Geolocator.openLocationSettings();
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(msg: "Location permissions are permanently denied, "
          "we cannot request permissions.");
      await Geolocator.openLocationSettings();
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    final position = await Geolocator.getCurrentPosition();
    return position;
  }

  static void showLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CupertinoPopupSurface(
          child: Material(
            child: WillPopScope(
              onWillPop: () async => false,
              child: Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Platform.isIOS
                        ? const CupertinoActivityIndicator(radius: 12)
                        : const CircularProgressIndicator(color: Colors.black),
                    const SizedBox(height: 8),
                    const AppText(title: "Please Wait")
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}