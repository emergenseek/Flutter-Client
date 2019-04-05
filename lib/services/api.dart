import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

Future<Post> sendSMS(List coordinates) async {
  var url = "https://tzuvifn7ng.execute-api.us-east-2.amazonaws.com/Prod/sms";
  Map<String,String> headers = {
    'Content-Type': 'application/json',
  };
  var body = jsonEncode({
    "user_id": "b4f2a0b9-5c63-4257-9655-a3ee2b0519a1",
    "type": 3,
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
    "user_id": "b4f2a0b9-5c63-4257-9655-a3ee2b0519a1",
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
    "user_id": "b4f2a0b9-5c63-4257-9655-a3ee2b0519a1",
  });

  final response = await http.post(url, headers: headers, body: body);
  print(json.decode(response.body));

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return LockscreenInfo.fromJson(json.decode(response.body));
  } else {
    // If the call was not successful, notify user of error code
    print("sendCall request failed. Error Code: ${response.statusCode}");
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

Future<void> callLocator(List<Detail> data) async {
  var url = "https://tzuvifn7ng.execute-api.us-east-2.amazonaws.com/Prod/locate";
  Map<String,String> headers = {
    'Content-Type': 'application/json',
  };
  var body = jsonEncode({
    "current_location": [-31.9517231, 115.8603252] 
  });

  final response = await http.post(url, headers: headers, body: body);

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    // And store it in the data object created by ServiceLocatorPageState
    fromJson(json.decode(response.body), data);
  } else {
    // If the call was not successful, notify user of error code
    print("callLocator request failed. Error Code: ${response.statusCode}");
  }
}

// main(List<String> arguments) async {
//   var response = await callLocator();
//   for (var i = 0; i < response.length; i++)  {
//     print(response[i].location["lat"]);
//     print(response[i].location["lng"]);
//     print(response[i].name);
//     print(response[i].icon);
//     print(response[i].open);
//   }
// }

void fromJson(List<dynamic> jsonList, List<Detail> data) {
  for (var i = 0; i < jsonList.length; i++)  {
    data.add(
      Detail.fromJson(jsonList[i])
    );
  }
}

class Detail {
  final Map<String, double> location;
  final String name;
  final String icon;
  final bool open;

  const Detail({this.location, this.name, this.icon, this.open});

  Detail.fromJson(Map jsonMap)
    : location = jsonMap['location'].cast<String, double>(),
      name = jsonMap['name'],
      icon = jsonMap['icon'],
      open = jsonMap['open'];
}