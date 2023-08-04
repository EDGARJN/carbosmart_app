import 'dart:convert';

import 'package:carbosmart/screens/home.dart';
import 'package:carbosmart/service/session.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class Waiter {
  Future getQuery(query, context) async {
    var qr = "Recommend a fertilizers, pesticides, farm preparation steps and crops that will not contribute in carbon emissions to cultivate if my soil pH is ${query}";
    Session.switchStatus("NO");
    var url = Uri.parse("https://f40d-41-222-181-163.eu.ngrok.io/chat");
    var resBody = await http.post(
      url,
      body: {'query': qr},
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
