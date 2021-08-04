import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share/share.dart';

class MyQRPage extends StatefulWidget {
  static final pageName = "QRPage";

  @override
  _MyQRPageState createState() => _MyQRPageState();
}

class _MyQRPageState extends State<MyQRPage> {
  build(context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("My QR Code"),
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.grey[200],
          ),
          //Qr Image
          Positioned(
              left: width / 10,
              right: width / 10,
              top: height / 7,
              bottom: height / 2.9,
              child: Container(
                  decoration: ShapeDecoration(
                      shape: Border.all(width: 1, color: Colors.white),
                      color: Colors.white),
                  child: QrImage(
                    data: "somthing somthing",
                    size: width * height / 1000,
                  )))
          //share button
          ,
          Positioned(
              left: width / 1.3,
              right: width / 20,
              top: height / 1.3,
              bottom: height / 40,
              child: Container(
                child: IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () {
                    Share.share("here share what ever you want");
                  },
                  color: Colors.white,
                ),
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.red),
              )),
        ],
      ),
    );
  }
}
