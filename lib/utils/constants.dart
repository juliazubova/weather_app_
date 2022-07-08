import 'package:flutter/material.dart';

const primaryColor = Color(0xff2c2c2c);
const blackColor = Colors.black;
const whiteColor = Colors.white;
const greyColor = Color(0xffc4c4c4);
const bgGreyColor = Color(0xfffdfcfc);
const darkGreyColor = Color(0xff9a9a9a);
const orangeColor = Color(0xffff9100);
const lightOrangeColor = Color(0xffffba58);
const blueColor = Color(0xff81e3f3);
const purpleColor = Color(0xffa781f3);
const pinkColor = Color(0xffffd0b8);
const greenColor = Color(0xff62fc4e);

// Custom ListTile for MainScreen
Widget customListTile({
  required String first,
  required String second,
  required IconData icon,
  required Color iconColor,
  String text = '',
}) {
  return ListTile(
    trailing: Text(text, style: TextStyle(fontSize: 20, color: primaryColor)),
    leading: Icon(icon, color: iconColor),
    title: RichText(
      maxLines: 1,
      text: TextSpan(
        children: [
          TextSpan(
            text: first,
            style: const TextStyle(
              color: primaryColor,
              fontSize: 20,
            ),
          ),
          TextSpan(
            text: second,
            style: TextStyle(
              color: iconColor,
              fontSize: 20,
            ),
          ),
        ],
      ),
    ),
  );
}

// API
// http://api.weatherapi.com/v1/forecast.json?key=072a70dfb1524a228e513807220807&q=Omsk&days=7&aqi=no&alerts=no
class Constants {
  static const String WEATHER_APP_ID = 'a45231e096bd4c0e8a4105213220707';
  static const String WEATHER_BASE_SCHEME = 'https://';
  static const String WEATHER_BASE_URL_DOMAIN = 'api.weatherapi.com';
  static const String WEATHER_FORECAST_PATH = '/v1/forecast.json';
}
