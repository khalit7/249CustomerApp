import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';

class ScanQRPage extends StatefulWidget {
  static final pageName = "ScanQRPage";
  @override
  _ScanQRPageState createState() => _ScanQRPageState();
}

class _ScanQRPageState extends State<ScanQRPage> {
  ScanResult scanResult;

  build(context) {
    scan();
    return Scaffold(body: SizedBox());
  }

  Future scan() async {
    scanResult = await BarcodeScanner.scan();
    if (scanResult.type.name ==
        "Cancelled") // nothing scanned ... just go back to the previous screen
    {
      Navigator.pop(context);
    } else {
      print("somthing detected" + scanResult.rawContent);
    }
  }
}
