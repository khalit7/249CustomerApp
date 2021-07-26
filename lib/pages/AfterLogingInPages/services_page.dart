//widgets
import 'package:customer249/widgets/custom_drawer.dart';
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
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //first row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ServiceWidget(
                      icon: Icons.meeting_room,
                      text: "Meeting Room",
                      onpressed: () {
                        print("pressed");
                      },
                    ),
                    ServiceWidget(
                      icon: Icons.group_work,
                      text: "Workplace",
                      onpressed: () {
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
                      icon: Icons.phone_in_talk,
                      text: "Consultancy",
                      onpressed: () {
                        print("pressed");
                      },
                    ),
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
          )),
    );
  }
}
