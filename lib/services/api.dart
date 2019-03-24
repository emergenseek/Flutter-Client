import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

Future<Post> sendSMS() async {
  var url = "https://tzuvifn7ng.execute-api.us-east-2.amazonaws.com/Prod/sms";
  Map<String,String> headers = {
    'Content-Type': 'application/json',
  };
  var body = jsonEncode({
    "user_id": "e78e0c86-f9ba-4375-9554-6dc1426f5605",
    "type": 3,
    "message": "Hello from Lambda, Simon"
  });

  final response = await http.post(url, headers: headers, body: body);
  print(json.decode(response.body));

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return Post.fromJson(json.decode(response.body));
  } else {
    // If the call was not successful, notify user of error code
    print("SendSMS request failed. Error Code: ${response.statusCode}");
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