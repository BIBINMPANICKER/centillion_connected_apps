import 'package:centillion/src/models/data_model.dart';
import 'package:centillion/src/models/device_app_model.dart';
import 'package:centillion/src/utils/colors.dart';
import 'package:centillion/src/utils/utils.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'card_painter.dart';

class CardItem extends StatefulWidget {
  final DataModel itemDetails;

  CardItem({this.itemDetails});

  @override
  _CardItemState createState() => _CardItemState(itemDetails);
}

class _CardItemState extends State<CardItem> {
  final DataModel itemDetails;
  bool _isInstalled = true;

  _CardItemState(this.itemDetails);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: screenWidth(context, dividedBy: 2.4),
      height: 180,

      // future builder widget for checking whether
      // an app installed in our device or not
      child: FutureBuilder<DeviceApp>(
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            _isInstalled = snapShot.data.isInstalled;
          }
          return Stack(
            children: <Widget>[
              Container(
                height: 132,
                margin: EdgeInsets.only(top: 38),
                child: CustomPaint(
                  foregroundPainter: CardPainter(),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    color: Colors.white,
                    elevation: 8,
                    child: Center(
                      child: ListTile(
                        enabled: _isInstalled ? true : false,
                        contentPadding: EdgeInsets.only(top: 28, bottom: 10),
                        title: Text(
                          itemDetails.title,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              itemDetails.subtitle,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 11),
                            ),

                            // conditionally hiding & enabling divider
                            !_isInstalled
                                ? Divider(
                                    indent: 8,
                                    endIndent: 8,
                                    thickness: 1,
                                  )
                                : SizedBox(),

                            // conditionally hiding & enabling the text 'Install app'
                            !_isInstalled
                                ? Text(
                                    'Install app',
                                    style: TextStyle(
                                        fontSize: 11, color: Color(0xFFFA4616)),
                                  )
                                : SizedBox()
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.topCenter,
                  child: snapShot.hasData

                      // show the app icon if installed
                      ? _isInstalled
                          ? CircleAvatar(
                              child: Image.memory(
                                snapShot.data.icon,
                                scale: 2.5,
                              ),
                              radius: 38,
                              backgroundImage:
                                  AssetImage("assets/Capture3.png"),
                            )
                          : CircleAvatar(
                              child: Image.asset('assets/Capture3.png'),
                              radius: 38,
                            )
                      : CircleAvatar(
                          child: Image.asset('assets/Capture3.png'),
                          radius: 38,
                        )),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: screenWidth(context, dividedBy: 6.5),
                    height: 30,
                    decoration: new BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        gradient: Colours.forwardGradient),
                    child: FlatButton(
                      padding: EdgeInsets.all(0),
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        // navigate to particular app if it was installed else to play_store
                        navigate(itemDetails.appId);
                      },
                    ),
                  ))
            ],
          );
        },

        // fetch the details(icon) of app which is already installed
        future: fetchAppDetails(itemDetails.appId),
      ),
    );
  }

  // check whether an app installed or not
  // fetch the details(icon) of app which is already installed
  Future<DeviceApp> fetchAppDetails(appId) async {
    bool isInstalled = await DeviceApps.isAppInstalled(appId);
    print(isInstalled);
    if (isInstalled) {
      ApplicationWithIcon app = await DeviceApps.getApp(appId, true);
      return DeviceApp(app.icon, isInstalled);
    }
    return DeviceApp(null, isInstalled);
  }

  // function for navigating to particular app if it was installed else to play_store
  navigate(appId) async {
    bool isInstalled = await DeviceApps.isAppInstalled(appId);

    // if the given app is previously installed
    // then navigate to that particular app
    if (isInstalled) {
      DeviceApps.openApp(appId);

      // if the given app is not previously installed then
      // navigate to that play_store for installing
    } else {
      var url = 'https://play.google.com/store/apps/details?id=$appId';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }
}
