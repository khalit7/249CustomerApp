import 'package:customer249/pages/AfterLogingInPages/services_page.dart';
import 'package:customer249/utils/validators.dart';
import 'package:customer249/widgets/Loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static final pageName = "LoginPage";

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  build(context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(),
        body: Stack(
          children: [
            Positioned(
              left: (width / 2) - ((width * height / 1500) / 2),
              right: (width / 2) - ((width * height / 1500) / 2),
              top: (height / 4),
              bottom: (height / 2) - (width * height / 2000),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Email"),
                      TextFormField(
                        controller: _emailController,
                        validator: emailValidator,
                      ),
                      SizedBox(
                        height: height / 50,
                      ),
                      Text("password"),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        validator: passwordValidator,
                      ),
                      SizedBox(
                        height: height / 25,
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            // Validate returns true if the form is valid, or false otherwise.
                            if (_formKey.currentState.validate()) {
                              // If the form is valid, login
                              await login(
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text.trim());
                            }
                          },
                          child: const Text('Submit'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }

  Future<void> login({String email, String password}) async {
    print("loggin in with $email and $password");
    showLoadingDialog(context);
    // login
    Navigator.pop(context);
    // go to services page
    Navigator.pushNamed(context, ServicesPage.pageName);
  }
}
