import 'package:customer249/utils/validators.dart';
import 'package:customer249/widgets/Loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  static final pageName = "Signup page";

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _password2Controller = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  build(context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          title: Text("Signup"),
        ),
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
                      Text("username"),
                      TextFormField(
                        controller: _usernameController,
                        validator: usernameValidator,
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
                        height: height / 50,
                      ),
                      Text("Confirm password"),
                      TextFormField(
                        controller: _password2Controller,
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
                              showLoadingDialog(context);
                              await signup(
                                  email: _emailController.text.trim(),
                                  username: _usernameController.text.trim(),
                                  password: _passwordController.text.trim());
                              Navigator.pop(context);
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

  Future<void> signup({String email, String username, String password}) async {
    print("signing up in with $email and $username and $password");
  }
}
