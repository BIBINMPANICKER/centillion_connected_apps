import 'package:centillion/src/ui/screens/login.dart';
import 'package:centillion/src/utils/colors.dart';
import 'package:flutter/material.dart';

// class for setting the overall theme of the app
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Colours.scaffoldBackgroundColor,
          primaryColor: Colours.primaryColor,
          textTheme: TextTheme()),
      home: Login(),
    );
  }
}
