import 'package:flutter/material.dart';

Future showSuccessWidget(var context, String sucessMessage) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
            title: Text("Success ! "),
            content: Text("$sucessMessage"),
            actions: [
              FlatButton(
                  onPressed: (() {
                    Navigator.pop(context);
                  }),
                  child: Text("OK"))
            ],
          ));
}
