import 'package:carbosmart/api/waiter.dart';
import 'package:carbosmart/service/session.dart';
import 'package:carbosmart/styles/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:share_plus/share_plus.dart';

class CarboSmartHomePage extends StatefulWidget {
  // final GoogleSignInAccount user;
  CarboSmartHomePage({super.key});

  @override
  State<CarboSmartHomePage> createState() => _CarboSmartHomePageState();
}

class _CarboSmartHomePageState extends State<CarboSmartHomePage> {
  final formKey = GlobalKey<FormState>();
  String? query;

  void queryActivity() {
    if (formKey.currentState!.validate()) {
      Waiter().getQuery(query, context);
    }
  }

  bool like = true;

  @override
  Widget build(BuildContext context) {
    double widths = MediaQuery.of(context).size.width;
    double heights = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor().mainColor,
        title: const Text("carbosmart"),
      ),
      body: Container(
        padding: const EdgeInsets.all(3.0),
        height: heights,
        width: widths,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Text(
              "Welcome, ",
              style: TextStyle(
                  color: AppColor().mainColor,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400),
            ),
            Card(
              color: AppColor().mainColor,
              child: Column(
                children: [
                  Text(
                    "Data From the Sensor",
                    style: TextStyle(color: AppColor().textColor),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: 8.0, bottom: 8.0, left: 20.0, right: 20.0),
                    height: heights * 0.1,
                    width: widths,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "N: 20%",
                          style: TextStyle(
                              color: AppColor().textColor, fontSize: 20.0),
                        ),
                        Text(
                          "P: 30.5%",
                          style: TextStyle(
                              color: AppColor().textColor, fontSize: 20.0),
                        ),
                        Text(
                          "K: 49.5%",
                          style: TextStyle(
                              color: AppColor().textColor, fontSize: 20.0),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        validator: (vale) =>
                            vale!.isEmpty ? "Please write something" : null,
                        onChanged: (val) {
                          setState(() {
                            query = val;
                          });
                        },
                        decoration:
                            InputDecoration(border: OutlineInputBorder(),
                            ),
                            maxLines: 3,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  Session.switchStatus("NO");
                                });
                              },
                              child: Text("clear")),
                          ElevatedButton(
                              onPressed: () {
                                queryActivity();
                                showDialog(
                                    context: context, builder: (context){
                                      return Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CircularProgressIndicator(color: AppColor().mainColor),
                                        ],
                                      );
                                    });
                              },
                              child: Text(
                                "Get Carbon based Recommendation",
                                style: TextStyle(color: AppColor().textColor),
                              )),
                        ],
                      ),
                    ),
                  ],
                )),
            Session.getSwitchStatus() == "YES"
                ? Card(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Share.share(Session.getRecommendation());
                                },
                                icon: const Icon(Icons.share),
                                color: AppColor().mainColor,
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      like = !like;
                                    });
                                  },
                                  icon: like
                                      ? Icon(Icons.favorite_border)
                                      : Icon(
                                          Icons.favorite,
                                          color: AppColor().mainColor,
                                        )),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(Session.getRecommendation(),
                              style: const TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w400),
                              textAlign: TextAlign.justify),
                        ),
                      ],
                    ),
                  )
                : Text(''),
          ],
        ),
      ),
    );
  }
}
