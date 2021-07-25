//widgets
import 'package:customer249/widgets/custom_drawer.dart';
//packages
import 'package:provider/provider.dart';
//main package
import 'package:flutter/material.dart';

class ServicesPage extends StatelessWidget {
  static final pageName = "ServicesPage";
  build(context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
          drawer: CustomDrawer(),
          appBar: AppBar(
            title: Text("Services"),
          ),
          body: Stack(
            children: [
              Container(color: Colors.grey[200]),
              SingleChildScrollView(
                child: Column(
                  // mainAxisAlignment: rowAllignment,
                  children: [
                    //first row
                    // Row(
                    //   mainAxisAlignment: rowAllignment,
                    //   children: [
                    //     CardWithImageAndText(
                    //         CustomIconButton(() {
                    //           Navigator.pushNamed(
                    //               context, ScanAndPayPage.pageName);
                    //         }, Icons.scanner),
                    //         Text(
                    //             Localization.of(context)
                    //                 .getTranslatedValue("Scan & Pay"),
                    //             style: TextStyle(color: Colors.red),
                    //             textScaleFactor: 1.2)),
                    //     CardWithImageAndText(
                    //         CustomIconButton(() {
                    //           Navigator.pushNamed(context, QRPage.pageName);
                    //         }, Icons.crop_free_rounded),
                    //         Text(
                    //           Localization.of(context)
                    //               .getTranslatedValue("My QR"),
                    //           style: TextStyle(color: Colors.red),
                    //           textScaleFactor: 1.2,
                    //         )),
                    //   ],
                    // ),

                    // //second row
                    // Row(
                    //   mainAxisAlignment: rowAllignment,
                    //   children: [
                    //     CardWithImageAndText(
                    //         CustomIconButton(() {
                    //           Navigator.pushNamed(
                    //               context, TelecomSevicesPage.pageName);
                    //         }, Icons.phone),
                    //         Text(
                    //             Localization.of(context)
                    //                 .getTranslatedValue("Telecom Services"),
                    //             style: TextStyle(color: Colors.red),
                    //             textScaleFactor: 1.2)),
                    //     CardWithImageAndText(
                    //         CustomIconButton(() {
                    //           Navigator.pushNamed(
                    //               context, ElectricityServicesPage.pageName);
                    //         }, Icons.bolt),
                    //         Text(
                    //             Localization.of(context)
                    //                 .getTranslatedValue("Electricity Services"),
                    //             style: TextStyle(color: Colors.red),
                    //             textScaleFactor: 1.2)),
                    // ],
                    // ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
