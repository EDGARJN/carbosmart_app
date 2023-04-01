import 'package:carbosmart/model/google_signin_api.dart';
import 'package:carbosmart/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    double heights = MediaQuery.of(context).size.height;
    double widths = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: heights,
        width: widths,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: signIn, child: Text("Sign In"))
          ],
        ),
      ),
    );
    
  }
  Future signIn() async {
  final user = await GoogleSignApi.login();

  if (user == null) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Sign In Failed")));
  } else {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => CarboSmartHomePage()));
  }
}
}


