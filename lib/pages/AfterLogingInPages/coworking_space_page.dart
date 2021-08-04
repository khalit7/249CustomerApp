import 'package:customer249/widgets/service_widget.dart';
import 'package:flutter/material.dart';

class CoworkingSpacePage extends StatelessWidget {
  static final pageName = "CoworkingSpacePage";
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Co-Working Space"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
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
          ],
        ),
      ),
    );
  }
}
