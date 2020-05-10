import 'package:centillion/src/managers/app_manager.dart';
import 'package:centillion/src/ui/widgets/card_item.dart';
import 'package:centillion/src/ui/widgets/home_painter.dart';
import 'package:centillion/src/utils/colors.dart';
import 'package:centillion/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'login.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();

    // refresh the screen after returning from another apps.
    SystemChannels.lifecycle.setMessageHandler((msg) {
      if (msg == AppLifecycleState.resumed.toString()) setState(() {});
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: CustomPaint(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                //widget for showing the logout the logout button
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: 42,
                      height: 28,
                      decoration: new BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          gradient: Colours.reverseGradient),
                      child: FlatButton(
                        padding: EdgeInsets.all(3),
                        child: Image.asset('assets/logout.png'),
                        onPressed: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4, right: 32),
                      child: Text('Logout',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                    )
                  ],
                ),

                // widget for showing the n no.of card items with app's details
                Wrap(
                    spacing: 16,
                    runSpacing: 12,
                    alignment: WrapAlignment.center,
                    children: apps
                        .getAppList()
                        .map((item) => CardItem(itemDetails: item))
                        .toList()),
                Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 14),
                    child: Image.asset(
                      'assets/centillion.png',
                      width: screenWidth(context, dividedBy: 2),
                    )),
              ],
            ),
            painter:
                CurvePainter(), // for giving the curve designs to the parent widget
          ),
        ),
      ),
    );
  }
}
