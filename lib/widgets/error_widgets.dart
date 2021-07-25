import 'package:flutter/material.dart';

Future showErrorWidget(var context, String errorMessage) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
            title: Text("Error ! "),
            content: Text("$errorMessage"),
            actions: [
              FlatButton(
                  onPressed: (() {
                    Navigator.pop(context);
                  }),
                  child: Text("OK"))
            ],
          ));
}
