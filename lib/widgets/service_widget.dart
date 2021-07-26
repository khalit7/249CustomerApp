import 'package:flutter/material.dart';

class ServiceWidget extends StatelessWidget {
  IconData icon;
  String text;
  var onpressed;
  ServiceWidget({this.icon, this.text, this.onpressed});
  build(context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.fromLTRB(0, width / 36, 0, width / 36),
      child: Ink(
        width: width / 3.5,
        height: width / 3.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          color: Colors.grey,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: InkWell(
          highlightColor: Colors.purple,
          onTap: onpressed,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.purple,
                size: width / 12,
              ),
              Text(
                text,
                textScaleFactor: 1.3,
                style: TextStyle(color: Colors.purple),
              )
            ],
          ),
        ),
      ),
    );
  }
}
