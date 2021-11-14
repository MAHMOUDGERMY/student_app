import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'cache/cashe_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

void navigateto(context, widget) => Navigator.pushReplacement(
    context, MaterialPageRoute(builder: (context) => widget));

void ShowToast({required String msg, required Color color}) =>
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);

void SignOut(context) {
  CacheHelper.removeData(key: "token").then((value) {
    if (value) {
      token = '';
      Navigator.of(context).pushReplacementNamed("Login");
    }
  });
}

String token = '';

var darktheme = ThemeData(
    cardTheme: CardTheme(color: HexColor("333739")),
    textTheme: TextTheme(
      caption: TextStyle(color: Colors.grey),
      bodyText1: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
      bodyText2: TextStyle(fontSize: 16, height: 1.2, color: Colors.white),
    ),
    scaffoldBackgroundColor: HexColor("333739"),
    primarySwatch: Colors.deepOrange,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.deepOrange,
        focusColor: Colors.red,
        hoverColor: Colors.green),
    appBarTheme: AppBarTheme(
        elevation: 0,
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: HexColor("333739"),
            statusBarIconBrightness: Brightness.light),
        backgroundColor: HexColor("333739"),
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        iconTheme: IconThemeData(color: Colors.white)),
    iconTheme: IconThemeData(color: Colors.white),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        backgroundColor: HexColor("333739"),
        elevation: 20.0));

var theme = ThemeData(
  cardTheme: CardTheme(color: Colors.white),
  textTheme: TextTheme(
    caption: TextStyle(color: Colors.grey),
    bodyText1: TextStyle(
        fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
    bodyText2: TextStyle(fontSize: 16, height: 1.2, color: Colors.black),
  ),
  primarySwatch: Colors.deepOrange,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.deepOrange,
      focusColor: Colors.red,
      hoverColor: Colors.green),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
      elevation: 0,
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark),
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      iconTheme: IconThemeData(color: Colors.black)),
  iconTheme: IconThemeData(color: Colors.black),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.deepOrange,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.white,
      elevation: 20.0),
);

var faculity_name = '';

var dict = {
  "to":
      "c3DfcgG3TsOnhLgfYrh0zR:APA91bEBG4gPeEBqWaucomBYkmvZVgBDMK_1QZhG8czNAnLsRi9f8U1AmPdCtIXfi6r-Xl3baHhAAzoM4HyB18bKOOrEFyr8qqPToT8u-F7T85gzEicvNNtECFxkRmC3eRwCyyfbGvLr",
  "notification": {
    "title": "تكنولوجيا المعلومات",
    "body": "محمد الفرا",
    "sound": "default"
  },
  "android": {
    "priority": "HIGH",
    "notification": {
      "notification_priority": "PRIORITY_MAX",
      "sound": "default",
      "default_sound": false,
      "default_vibrate_timing": true,
      "default_light_setting": true
    }
  },
  "data": {}
};
