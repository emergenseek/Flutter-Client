import 'package:flutter/material.dart';
import 'package:flutter_app/util/animations.dart';
import 'package:flutter_app/screens/nav_menu.dart';
import 'package:flutter_app/screens/settings.dart';

class SOSPage extends StatefulWidget {
  static _SOSPageState of(BuildContext context) => context.ancestorStateOfType(const TypeMatcher<_SOSPageState>());
  @override
  _SOSPageState createState() => _SOSPageState();
}

class _SOSPageState extends State<SOSPage> {
  bool _notifyUsers = false;
  bool _displayLockscreenInfo = true;
  bool _sosActive = false;

  void activateSOS() {
    setState(() {
      _sosActive = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
        body: Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _sosActive == true ? ShowUp(
              child: Text("S.O.S. Alert Broadcasted", style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w300)),
              delay: 500,
            ) : Container(),
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
                    fillColor: _sosActive == false ? Colors.white : Colors.black,
                    child: new Icon(
                      Icons.error_outline,
                      color: _sosActive == false ? Colors.blue[200] : Colors.red,
                      size: 150.0,
                    ),
                    onPressed: () {}),
                LoadingButton()
              ],
            )
          ],
        )));
  }
}

class LoadingButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _LoadingButtonState();
  }
}

class _LoadingButtonState extends State<LoadingButton> with SingleTickerProviderStateMixin {
  AnimationController controller;

  bool _sosActive = false;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    controller.addListener(() {
      setState(() {});
    });
  }

  void resetProgress() {
    controller.reset();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTapDown: (_) => controller.forward(),
        onTapUp: (_) {
          if (controller.status == AnimationStatus.forward) {
            controller.reverse();
          }
          else if (controller.status == AnimationStatus.completed) {
            // Notify SOSPage widget of hold completion
            SOSPage.of(context).activateSOS();
            setState(() {
              _sosActive = true;
            });
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
              )
            ),
            SizedBox(
                height: 200.0,
                width: 200.0,
              child: CircularProgressIndicator(
                value: controller.value,
                valueColor: AlwaysStoppedAnimation<Color>(_sosActive == false ? Colors.blue[200] : Colors.red),
              )
            ),
          ],
        ));
  }
}
