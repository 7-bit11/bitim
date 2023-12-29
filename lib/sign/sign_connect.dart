import 'dart:convert';

import 'package:flutter_openim_sdk/flutter_openim_sdk.dart';
import 'package:get/get.dart';

class SignConnect extends GetConnect {
  Future<Response> postUser() async {
    return post(
        'http://47.108.13.160:10002/auth/user_token',
        jsonEncode({
          "secret": "openIM123",
          "platformID": IMPlatform.android,
          "userID": "5771974879"
        }),
        headers: {
          "operationID": '1646445464564',
          'Accept': 'application/json',
        },
        contentType: "application/json");
  }
}
