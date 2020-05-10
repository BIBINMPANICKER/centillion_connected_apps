import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// function for showing custom toast message
void showToast(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
  );
}

Size screenSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

// function to calculate the height of the device_screen
double screenHeight(BuildContext context, {double dividedBy = 1}) {
  return screenSize(context).height / dividedBy;
}

// function to calculate the width of the device_screen
double screenWidth(BuildContext context, {double dividedBy = 1}) {
  return screenSize(context).width / dividedBy;
}
