import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

Future<Post> sendSMS(List coordinates, int alertType) async {
  var url = "https://tzuvifn7ng.execute-api.us-east-2.amazonaws.com/Prod/sms";
  Map<String,String> headers = {
    'Content-Type': 'application/json',
  };
  var body = jsonEncode({
    "user_id": "b945b2f7-8970-4a14-834f-c3e8bcd1928b",
    "type": alertType,  // 1 = Severe, 2 = Mild, 3 = Check In
    "message": "This is an SOS Emergency Alert from EmergenSeek",
    "last_known_location": coordinates,
  });

  final response = await http.post(url, headers: headers, body: body);
  print(json.decode(response.body));

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return Post.fromJson(json.decode(response.body));
  } else {
    // If the call was not successful, notify user of error code
    print("sendSMS request failed. Error Code: ${response.statusCode}");
  }
}

Future<Post> sendCall(List coordinates) async {
  var url = "https://tzuvifn7ng.execute-api.us-east-2.amazonaws.com/Prod/voice";
  Map<String,String> headers = {
    'Content-Type': 'application/json',
  };
  var body = jsonEncode({
    "user_id": "b945b2f7-8970-4a14-834f-c3e8bcd1928b",
    "last_known_location": coordinates
  });

  final response = await http.post(url, headers: headers, body: body);
  print(json.decode(response.body));

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return Post.fromJson(json.decode(response.body));
  } else {
    // If the call was not successful, notify user of error code
    print("sendCall request failed. Error Code: ${response.statusCode}");
  }
}

Future<LockscreenInfo> getLockscreenInfo() async {
  var url = "https://tzuvifn7ng.execute-api.us-east-2.amazonaws.com/Prod/lock";
  Map<String,String> headers = {
    'Content-Type': 'application/json',
  };
  var body = jsonEncode({
    "user_id": "b945b2f7-8970-4a14-834f-c3e8bcd1928b",
  });

  final response = await http.post(url, headers: headers, body: body);
  print(json.decode(response.body));

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return LockscreenInfo.fromJson(json.decode(response.body));
  } else {
    // If the call was not successful, notify user of error code
    print("getLockscreenInfo request failed. Error Code: ${response.statusCode}");
  }
}

void updateSettings(sos_sms, sos_calls, sos_lockscreen, updates, update_frequency) async {
  //TODO: Update url to dynamically use the user's UID
  var url = "https://tzuvifn7ng.execute-api.us-east-2.amazonaws.com/Prod/settings/b945b2f7-8970-4a14-834f-c3e8bcd1928b";
  Map<String,String> headers = {
    'Content-Type': 'application/json',
  };
  var body = jsonEncode({
    //"user_id": "b945b2f7-8970-4a14-834f-c3e8bcd1928b",
    "sos_sms": sos_sms,
    "sos_calls": sos_calls,
    "sos_lockscreen": sos_lockscreen,
    "updates": updates,
    "update_frequency": update_frequency,
  });

  final response = await http.patch(url, headers: headers, body: body);
  print(json.decode(response.body));

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    //return LockscreenInfo.fromJson(json.decode(response.body));
  } else {
    // If the call was not successful, notify user of error code
    print("updateSettings request failed. Error Code: ${response.statusCode}");
  }
}

Future<Settings> getSettings() async {
  //TODO: Update url to dynamically use the user's UID
  var url = "https://tzuvifn7ng.execute-api.us-east-2.amazonaws.com/Prod/settings/b945b2f7-8970-4a14-834f-c3e8bcd1928b";
  Map<String,String> headers = {
    'Content-Type': 'application/json',
  };
  var body = jsonEncode({
    //"user_id": "b945b2f7-8970-4a14-834f-c3e8bcd1928b",
  });

  final response = await http.get(url, headers: headers);
  print(json.decode(response.body));

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return Settings.fromJson(json.decode(response.body));
  } else {
    // If the call was not successful, notify user of error code
    print("getSettings request failed. Error Code: ${response.statusCode}");
  }
}

void addNewContact(phone_number, relationship, first_name, last_name, email_address, tier) async {
  //TODO: Update url to dynamically use the user's UID
  var url = "https://tzuvifn7ng.execute-api.us-east-2.amazonaws.com/Prod/contact/b945b2f7-8970-4a14-834f-c3e8bcd1928b";
  Map<String,String> headers = {
    'Content-Type': 'application/json',
  };
  var body = jsonEncode({
    //"user_id": "b945b2f7-8970-4a14-834f-c3e8bcd1928b",
    "phone_number": phone_number,
    "relationship": relationship,
    "first_name": first_name,
    "last_name": last_name,
    "email_address": email_address,
    "tier": tier,
  });

  final response = await http.post(url, headers: headers, body: body);
  print(json.decode(response.body));

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    //return Settings.fromJson(json.decode(response.body));
  } else {
    // If the call was not successful, notify user of error code
    print("addContact request failed. Error Code: ${response.statusCode}");
  }
}

void updateContactTier(phone_number, new_tier) async {
  //TODO: Update url to dynamically use the user's UID
  var url = "https://tzuvifn7ng.execute-api.us-east-2.amazonaws.com/Prod/tier/b945b2f7-8970-4a14-834f-c3e8bcd1928b";
  Map<String,String> headers = {
    'Content-Type': 'application/json',
  };
  var body = jsonEncode({
    //"user_id": "b945b2f7-8970-4a14-834f-c3e8bcd1928b",
    "phone_number": phone_number,
    "new_tier": new_tier,
  });

  final response = await http.put(url, headers: headers, body: body);
  print(json.decode(response.body));

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    //return Settings.fromJson(json.decode(response.body));
  } else {
    // If the call was not successful, notify user of error code
    print("updateContactTier request failed. Error Code: ${response.statusCode}");
  }
}

class Post {
  final String userId;
  final int type;
  final String message;
  final List<double> last_known_location;

  Post({this.userId, this.type, this.message, this.last_known_location});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      type: json['type'],
      message: json['message'],
      last_known_location: json['last_known_location'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["userId"] = userId;
    map["type"] = type;
    map["message"] = message;
    map["last_known_location"] = last_known_location;

    return map;
  }
}

class LockscreenInfo {
  final String first_name;
  final String last_name;
  final String blood_type;
  final int age;
  final Map<String, String> primary_residence;
  final int phone_pin;
  final String email_address;
  final String phone_number;

  LockscreenInfo({this.first_name, this.last_name, this.blood_type, this.age,
        this.primary_residence, this.phone_pin, this.email_address, this.phone_number});

  factory LockscreenInfo.fromJson(Map<String, dynamic> json) {
    return LockscreenInfo(
      first_name: json['first_name'],
      last_name: json['last_name'],
      blood_type: json['blood_type'],
      age: json['age'],
      //primary_residence: json['primary_residence'],
      phone_pin: json['phone_pin'],
      email_address: json['email_address'],
      phone_number: json['phone_number'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["first_name"] = first_name;
    map["last_name"] = last_name;
    map["blood_type"] = blood_type;
    map["age"] = age;
    //map["primary_residence"] = primary_residence;
    map["phone_pin"] = phone_pin;
    map["email_address"] = email_address;
    map["phone_number"] = phone_number;

    return map;
  }
}

class Settings {
  final bool sos_sms;
  final bool sos_calls;
  final bool sos_lockscreen;
  final bool updates;
  final bool update_frequency;

  Settings({this.sos_sms, this.sos_calls, this.sos_lockscreen, this.updates, this.update_frequency});

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      sos_sms: json['sos_sms'],
      sos_calls: json['sos_calls'],
      sos_lockscreen: json['sos_lockscreen'],
      updates: json['updates'],
      update_frequency: json['update_frequency'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["sos_sms"] = sos_sms;
    map["sos_calls"] = sos_calls;
    map["sos_lockscreen"] = sos_lockscreen;
    map["updates"] = updates;
    map["update_frequency"] = update_frequency;

    return map;
  }
}