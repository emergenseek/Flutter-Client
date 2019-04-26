import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

Future<Post> sendSMS(List coordinates, int alertType, String uid) async {
  var url = "https://tzuvifn7ng.execute-api.us-east-2.amazonaws.com/Prod/sms";
  Map<String, String> headers = {
    'Content-Type': 'application/json',
  };
  var body = jsonEncode({
    "user_id": uid,
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

Future<Post> sendUpdateSMS(List coordinates, String uid) async{
  var url = "https://tzuvifn7ng.execute-api.us-east-2.amazonaws.com/Prod/sms";
      Map<String,String> headers ={
  'Content-Type': 'application/json',
  };
  var body = jsonEncode({
  "user_id": uid,
  "last_known_location": coordinates,
  "message": "EmergenSeek Location Check-In Test",
  "type": 3,
  });

  final response = await http.post(url, headers: headers, body: body);
  print(json.decode(response.body));

  if(response.statusCode != 200)
    print("sendUpdateSMS request failed. Error Code: ${response.statusCode}");

  else
    return Post.fromJson(json.decode(response.body));
}

Future<Post> locationPolling(List coordinates, String uid) async{
  var url = "https://tzuvifn7ng.execute-api.us-east-2.amazonaws.com/Prod/poll";
  Map<String,String> headers = {
    'Content-Type': 'application/json',
  };

  var body = jsonEncode({
    "user_id": uid,
    "last_known_location": coordinates,
    "type": 3,
  });

  final response = await http.post(url, headers: headers, body: body);
  print(json.decode(response.body));

  if(response.statusCode != 200){
    print("locationPolling request failed. Error Code: ${response.statusCode}");
  }

  else{
    return Post.fromJson(json.decode(response.body));
  }
}

Future<Post> sendCall(List coordinates, String uid) async {
  var url = "https://tzuvifn7ng.execute-api.us-east-2.amazonaws.com/Prod/voice";
  Map<String, String> headers = {
    'Content-Type': 'application/json',
  };
  var body = jsonEncode({
    "user_id": uid,
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

Future<EmergencyInfo> getEmergencyInfo(List coordinates) async {
  var url = "https://tzuvifn7ng.execute-api.us-east-2.amazonaws.com/Prod/number/${coordinates[0]}/${coordinates[1]}";
  Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  final response = await http.get(url, headers: headers);
  print(json.decode(response.body));

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return EmergencyInfo.fromJson(json.decode(response.body));
  } else {
    // If the call was not successful, notify user of error code
    print("sendCall request failed. Error Code: ${response.statusCode}");
  }
}

Future<LockscreenInfo> getLockscreenInfo(String uid) async {
  var url = "https://tzuvifn7ng.execute-api.us-east-2.amazonaws.com/Prod/lock";
  Map<String, String> headers = {
    'Content-Type': 'application/json',
  };
  var body = jsonEncode({
    "user_id": uid,
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

void updateSettings(sos_sms, sos_calls, sos_lockscreen, updates, update_frequency, String uid) async {
  var url = "https://tzuvifn7ng.execute-api.us-east-2.amazonaws.com/Prod/settings/$uid";
  Map<String,String> headers = {
    'Content-Type': 'application/json',
  };
  var body = jsonEncode({
    "sos_sms": sos_sms,
    "sos_calls": sos_calls,
    "sos_lockscreen": sos_lockscreen,
    "updates": updates,
    "update_frequency": update_frequency,
  });

  final response = await http.patch(url, headers: headers, body: body);
  print(json.decode(response.body));

  if (response.statusCode == 200) {
  } else {
    // If the call was not successful, notify user of error code
    print("updateSettings request failed. Error Code: ${response.statusCode}");
  }
}

Future<Settings> getSettings(String uid) async {
  var url = "https://tzuvifn7ng.execute-api.us-east-2.amazonaws.com/Prod/settings/$uid";
  Map<String,String> headers = {
    'Content-Type': 'application/json',
  };

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

void createUser(Map<String, dynamic> profile) async {
  var url = "https://tzuvifn7ng.execute-api.us-east-2.amazonaws.com/Prod/create";
  Map<String,String> headers = {
    'Content-Type': 'application/json',
  };

  var body = jsonEncode({
    "user_id": profile["user_id"],
    "first_name": profile["first_name"],
    "last_name": profile["last_name"],
    "blood_type": profile["blood_type"],
    "age": profile["age"],
    "primary_residence": {
      "city": "Lubbock",
      "country": "United States of America",
      "line1": "3138 4th St",
      "line2": "Apt 101",
      "state": "Texas",
      "zip_code": "79415"
    },
    "phone_pin": profile["phone_pin"],
    "email_address": profile["email_address"],
    "phone_number": profile["phone_number"],
  });

  final response = await http.put(url, headers: headers, body: body);
  print(json.decode(response.body));

  if (response.statusCode == 200) {
  } else {
    // If the call was not successful, notify user of error code
    print("createUser request failed. Error Code: ${response.statusCode}");
  }
}

Future<Profile> getProfile(String uid) async {
  var url = "https://tzuvifn7ng.execute-api.us-east-2.amazonaws.com/Prod/profile/$uid";
  Map<String,String> headers = {
    'Content-Type': 'application/json',
  };

  final response = await http.get(url, headers: headers);
  print(json.decode(response.body));

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return Profile.fromJson(json.decode(response.body));
  } else {
    // If the call was not successful, notify user of error code
    print("getProfile request failed. Error Code: ${response.statusCode}");
    return null;
  }
}

void updateProfile(Map<String, dynamic> profile, String uid) async {
  var url = "https://tzuvifn7ng.execute-api.us-east-2.amazonaws.com/Prod/profile/$uid";
  Map<String,String> headers = {
    'Content-Type': 'application/json',
  };
  var body = jsonEncode({
    "first_name": profile["first_name"],
    "last_name": profile["last_name"],
    "blood_type": profile["blood_type"],
    "age": profile["age"],
    "primary_residence": {
      "city": "Lubbock",
      "country": "United States of America",
      "line1": "3138 4th St",
      "line2": "Apt 101",
      "state": "Texas",
      "zip_code": "79415"
    },
    "phone_pin": profile["phone_pin"],
    "email_address": profile["email_address"],
    "phone_number": profile["phone_number"],
  });

  final response = await http.patch(url, headers: headers, body: body);
  print(json.decode(response.body));

  if (response.statusCode == 200) {
  } else {
    // If the call was not successful, notify user of error code
    print("updateProfile request failed. Error Code: ${response.statusCode}");
  }
}

void addNewContact(phone_number, relationship, first_name, last_name, email_address, tier, String uid) async {
  var url = "https://tzuvifn7ng.execute-api.us-east-2.amazonaws.com/Prod/contact/$uid";
  Map<String,String> headers = {
    'Content-Type': 'application/json',
  };
  var body = jsonEncode({
    "phone_number": phone_number,
    //"relationship": relationship,
    "first_name": first_name,
    "last_name": last_name,
    //"email_address": email_address,
    "tier": tier,
  });

  final response = await http.post(url, headers: headers, body: body);
  print(json.decode(response.body));

  if (response.statusCode == 200) {
  } else {
    // If the call was not successful, notify user of error code
    print("addNewContact request failed. Error Code: ${response.statusCode}");
  }
}

void updateContactTier(phone_number, new_tier, String uid) async {
  var url = "https://tzuvifn7ng.execute-api.us-east-2.amazonaws.com/Prod/tier/$uid";
  Map<String,String> headers = {
    'Content-Type': 'application/json',
  };
  var body = jsonEncode({
    "phone_number": phone_number,
    "new_tier": new_tier,
  });

  final response = await http.put(url, headers: headers, body: body);
  print(json.decode(response.body));

  if (response.statusCode == 200) {
  } else {
    // If the call was not successful, notify user of error code
    print("updateContactTier request failed. Error Code: ${response.statusCode}");
  }
}

Future<void> callLocator(List<Detail> data) async {
  var url =
      "https://tzuvifn7ng.execute-api.us-east-2.amazonaws.com/Prod/locate";
  Map<String, String> headers = {
    'Content-Type': 'application/json',
  };
  var body = jsonEncode({
    "current_location": [-31.9517231, 115.8603252]
  });

  final response = await http.post(url, headers: headers, body: body);
  print(json.decode(response.body));

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    // And store it in the data object created by ServiceLocatorPageState
    return fromJson(json.decode(response.body), data);
  } else {
    // If the call was not successful, notify user of error code
    print("callLocator request failed. Error Code: ${response.statusCode}");
  }
}

void fromJson(List<dynamic> jsonList, List<Detail> data) {
  for (var i = 0; i < jsonList.length; i++) {
    data.add(Detail.fromJson(jsonList[i]));
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

class EmergencyInfo {
  final String country_code;
  final String police;
  final String ambulance;
  final String fire;

  EmergencyInfo({this.country_code, this.police, this.ambulance, this.fire});

  factory EmergencyInfo.fromJson(Map<String, dynamic> json) {
    return EmergencyInfo(
      country_code: json['country_code'],
      police: json['police'],
      ambulance: json['ambulance'],
      fire: json['fire'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["country_code"] = country_code;
    map["police"] = police;
    map["ambulance"] = ambulance;
    map["fire"] = fire;

    return map;
  }
}

class LockscreenInfo {
  final String first_name;
  final String last_name;
  final String blood_type;
  final int age;
  final Map<dynamic, dynamic> primary_residence;
  final int phone_pin;
  final String email_address;
  final String phone_number;

  LockscreenInfo(
      {this.first_name,
      this.last_name,
      this.blood_type,
      this.age,
      this.primary_residence,
      this.phone_pin,
      this.email_address,
      this.phone_number});

  factory LockscreenInfo.fromJson(Map<String, dynamic> json) {
    return LockscreenInfo(
      first_name: json['first_name'],
      last_name: json['last_name'],
      blood_type: json['blood_type'],
      age: json['age'],
      primary_residence: json['primary_residence'],
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
    map["primary_residence"] = primary_residence;
    map["phone_pin"] = phone_pin;
    map["email_address"] = email_address;
    map["phone_number"] = phone_number;

    return map;
  }
}

class Profile {
  final String first_name;
  final String last_name;
  final String blood_type;
  final int age;
  final Iterable<dynamic> contacts;
  final Map<dynamic, dynamic> primary_residence;
  final int phone_pin;
  final String email_address;
  final String phone_number;

  Profile({this.first_name, this.last_name, this.blood_type, this.age, this.contacts,
    this.primary_residence, this.phone_pin, this.email_address, this.phone_number});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      first_name: json['first_name'],
      last_name: json['last_name'],
      blood_type: json['blood_type'],
      age: json['age'],
      contacts: json['contacts'],
      primary_residence: json['primary_residence'],
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
    map["contacts"] = contacts;
    map["primary_residence"] = primary_residence;
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

class Detail {
  final Map<String, double> location;
  final String name;
  final String icon;
  final bool open;

  Detail({this.location, this.name, this.icon, this.open});

  factory Detail.fromJson(Map<String, dynamic> json) {
    return Detail(
      location: json['location'].cast<String, double>(),
      name: json['name'],
      open: json['open'],
      icon: json['icon'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    
    map["location"] = location;
    map["name"] = name;
    map["open"] = open;
    map["icon"] = icon;

    return map;
  }
}

