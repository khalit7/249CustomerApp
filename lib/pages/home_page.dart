// main package
import 'package:customer249/pages/login_page.dart';
import 'package:customer249/pages/signup_page.dart';
import 'package:customer249/widgets/custom_flat_button.dart';
import 'package:flutter/material.dart';
//widgets

class HomePage extends StatelessWidget {
  static final pageName = "HomePage";
  build(context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text("249 StartUps"),
        ),
        body: Stack(children: [
          Positioned(
            left: (width / 2) - ((width * height / 1500) / 2),
            right: (width / 2) - ((width * height / 1500) / 2),
            top: (height / 3),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomFlatButton1(width, height, "LOGIN", () {
                    Navigator.pushNamed(context, LoginPage.pageName);
                  }, 1000, 18.0, Colors.white, Colors.purple),
                  CustomFlatButton1(width, height, "SIGNUP", () {
                    Navigator.pushNamed(context, SignupPage.pageName);
                  }, 1000, 18.0, Colors.white, Colors.grey)
                ],
              ),
            ),
          ),
        ]));
  }
}
