import 'package:flutter/material.dart';
import 'package:flutter_app/util/animations.dart';
import 'package:flutter_app/screens/nav_menu.dart';
import 'package:flutter_app/screens/settings.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_app/models/sos_model.dart';

// SOS Screen itself, contains an app bar and the SOS button
class SOSPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.blueGrey[400],
        drawer: NavMenu(),
        appBar: AppBar(
          title: Text("S.O.S."),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.settings),
              tooltip: 'Settings',
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingsSOS()));
              },
            )
          ],
        ),
        body: Center(child: SOSButton()));
  }
}

// The SOS button, contains the button and the progress ring
class SOSButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<SOSModel>(
        builder: (context, child, sos) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                sos.getSOSStatus() == true
                    ? ShowUp(
                        child: Text("S.O.S. Alert Broadcasted",
                            style: TextStyle(
                                fontSize: 25.0, fontWeight: FontWeight.w300)),
                        delay: 500,
                      )
                    : Container(),
                Padding(
                  padding: EdgeInsets.all(32.0),
                ),
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    RawMaterialButton(
                        padding: EdgeInsets.all(15.0),
                        elevation: 10.0,
                        shape: new CircleBorder(),
                        fillColor: sos.getSOSStatus() == false
                            ? Colors.white
                            : Colors.black,
                        child: new Icon(
                          Icons.error_outline,
                          color: sos.getSOSStatus() == false
                              ? Colors.blue[200]
                              : Colors.red,
                          size: 150.0,
                        ),
                        onPressed: () {}),
                    ProgressRing()
                  ],
                )
              ],
            ));
  }
}

// The progress indicator for pressing and holding the SOS button
// Updates the SOS model upon completion
class ProgressRing extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _ProgressRingState();
  }
}

class _ProgressRingState extends State<ProgressRing>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    controller.addListener(() {
      setState(() {});
    });
  }

  void resetProgress() {
    controller.reset();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<SOSModel>(
        builder: (context, child, sos) => GestureDetector(
            onTapDown: (_) => controller.forward(),
            onTapUp: (_) {
              if (controller.status == AnimationStatus.forward) {
                controller.reverse();
              } else if (controller.status == AnimationStatus.completed) {
                sos.activateSOS();
              }
            },
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                SizedBox(
                    height: 200.0,
                    width: 200.0,
                    child: CircularProgressIndicator(
                      value: 1.0,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )),
                SizedBox(
                    height: 200.0,
                    width: 200.0,
                    child: CircularProgressIndicator(
                      value: controller.value,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          sos.getSOSStatus() == false
                              ? Colors.blue[200]
                              : Colors.red),
                    )),
              ],
            )));
  }
}
