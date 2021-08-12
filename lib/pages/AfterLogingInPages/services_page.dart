//widgets
import 'package:customer249/models/resource_model.dart';
import 'package:customer249/pages/AfterLogingInPages/coworking_space_page.dart';
import 'package:customer249/pages/AfterLogingInPages/my_qr_page.dart';
import 'package:customer249/pages/AfterLogingInPages/scan_qr_page.dart';
import 'package:customer249/provider/api_services.dart';
import 'package:customer249/widgets/Loading_widget.dart';
import 'package:customer249/widgets/custom_drawer.dart';
import 'package:customer249/widgets/loading_page.dart';
import 'package:customer249/widgets/service_widget.dart';
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
          backgroundColor: Colors.grey[200],
          drawer: CustomDrawer(),
          appBar: AppBar(
            title: Text("Services"),
          ),
          body: FutureBuilder(
              future: context.read<ApiService>().getUser(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return LoadingPage();
                } else
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // first row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ServiceWidget(
                              icon: Icons.scanner,
                              text: "Scan QR code",
                              onpressed: () {
                                Navigator.pushNamed(
                                    context, ScanQRPage.pageName);
                              },
                            ),
                            ServiceWidget(
                              icon: Icons.crop_free_rounded,
                              text: "My QR Code",
                              onpressed: () {
                                Navigator.pushNamed(context, MyQRPage.pageName);
                                print("pressed");
                              },
                            ),
                          ],
                        ),
                        //second row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ServiceWidget(
                                icon: Icons.meeting_room,
                                text: "Co-Working Space",
                                onpressed: () async {
                                  await loadAllResources(context);
                                  Navigator.pushNamed(
                                      context, CoworkingSpacePage.pageName);
                                }),
                            ServiceWidget(
                              icon: Icons.phone_in_talk,
                              text: "Consultancy",
                              onpressed: () {
                                print("pressed");
                              },
                            ),
                          ],
                        ),

                        //third row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ServiceWidget(
                              icon: Icons.assistant,
                              text: "Mentorship",
                              onpressed: () {
                                print("pressed");
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
              })),
    );
  }

  Future<void> loadAllResources(context) async {
    if (ResourceModel.allResources.isNotEmpty) return;
    //else
    showLoadingDialog(context);
    await Provider.of<ApiService>(context, listen: false).getAllResources();
    Navigator.pop(context);
  }
}
