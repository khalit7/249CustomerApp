import 'package:customer249/models/resource_model.dart';
import 'package:customer249/pages/AfterLogingInPages/book_resource_page.dart';
import 'package:customer249/provider/api_services.dart';
import 'package:customer249/widgets/Loading_widget.dart';
import 'package:customer249/widgets/service_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoworkingSpacePage extends StatefulWidget {
  static final pageName = "CoworkingSpacePage";

  @override
  _CoworkingSpacePageState createState() => _CoworkingSpacePageState();
}

class _CoworkingSpacePageState extends State<CoworkingSpacePage> {
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
                  onpressed: () async {
                    await listResourceAvailability(context, "meeting", 0);
                  },
                ),
                ServiceWidget(
                  icon: Icons.group_work,
                  text: "Shared Desk",
                  onpressed: () {},
                ),
              ],
            ),
            // second row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ServiceWidget(
                  icon: Icons.workspaces_filled,
                  text: "Dedicated table",
                  onpressed: () {},
                ),
                ServiceWidget(
                  icon: Icons.outdoor_grill,
                  text: "Out Door Event",
                  onpressed: () {},
                ),
              ],
            ),
            // third row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ServiceWidget(
                  icon: Icons.house,
                  text: "In Door Event",
                  onpressed: () {},
                ),
              ],
            ),
          ])),
    );
  }

  Future<void> listResourceAvailability(
      context, String resourceService, int capacity) async {
    showLoadingDialog(context);
    // make the API call here
    List<ResourceModel> roomsAvailable =
        await Provider.of<ApiService>(context, listen: false)
            .checkResourceAvailability(capacity, "meeting");
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => BookResourcePage(resources: roomsAvailable)),
    );
  }
}
