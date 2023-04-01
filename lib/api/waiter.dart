import 'dart:convert';


import 'package:carbosmart/screens/home.dart';
import 'package:carbosmart/service/session.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class Waiter {
  Future getQuery(query, context) async {
    Session.switchStatus("NO");
    var url = Uri.parse("https://df7a-41-222-181-182.in.ngrok.io/chat");
    var resBody = await http.post(
      url,
      body: {'query': query},
    );
    var decodable = jsonEncode(resBody.body);
    var data = jsonDecode(resBody.body);
    if (200 == 200) {
      // print(data);
      Session.switchStatus("YES");
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => CarboSmartHomePage()));
      Session.setRecommendation(data["response"]);

    } else {
      // print(resBody);
      print('error');
    }
  }
}
