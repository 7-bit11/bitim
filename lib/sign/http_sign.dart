import 'dart:convert';

import 'package:flutter_openim_sdk/flutter_openim_sdk.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class HttpB {
  Future<Response> get1() async {
    return await http.post(
      Uri.parse('http://47.108.13.160:10002/auth/user_token'),
      body: jsonEncode({
        "secret": "openIM123",
        "platformID": IMPlatform.android,
        "userID": "5771974879"
      }),
      headers: {
        "operationID": '8',
        'Accept': 'application/json',
      },
    );
  }
}
