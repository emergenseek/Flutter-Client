import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notifications {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  Notifications() {
    initializeNotifications();
  }

  void initializeNotifications() {
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid = AndroidInitializationSettings('sos');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future displaySOSNotification() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'SOS Alert Active', 'You are currently broadcasting an SOS alert', platformChannelSpecifics,
        payload: 'item id 2');
  }

  Future displayLockscreenNotification(String first_name, String last_name, String blood_type, int age) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        1, 'Personal Information', 'Name: $first_name $last_name, Blood Type: $blood_type, Age: $age', platformChannelSpecifics,
        payload: 'item id 2');
  }

  Future cancelNotification() async {
    //await flutterLocalNotificationsPlugin.cancel(0);
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}