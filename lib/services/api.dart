import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

Future<Post> sendSMS() async {
  var url = "https://tzuvifn7ng.execute-api.us-east-2.amazonaws.com/Prod/sms";
  Map<String,String> headers = {
    'Content-Type': 'application/json',
  };
  var body = jsonEncode({
    "user_id": "b4f2a0b9-5c63-4257-9655-a3ee2b0519a1",
    "type": 3,
    "message": "Hello from Lambda, Derek"
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

Future<Post> sendCall() async {
  var url = "https://tzuvifn7ng.execute-api.us-east-2.amazonaws.com/Prod/voice";
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
    return Post.fromJson(json.decode(response.body));
  } else {
    // If the call was not successful, notify user of error code
    print("sendCall request failed. Error Code: ${response.statusCode}");
  }
}

class Post {
  final String userId;
  final int type;
  final String message;

  Post({this.userId, this.type, this.message});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      type: json['type'],
      message: json['message'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["userId"] = userId;
    map["type"] = type;
    map["message"] = message;

    return map;
  }
}