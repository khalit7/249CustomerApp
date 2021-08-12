import 'package:customer249/widgets/resource_booking_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:customer249/models/resource_model.dart';
import 'package:customer249/provider/api_services.dart';
import 'package:customer249/widgets/Loading_widget.dart';
import 'package:date_time_picker/date_time_picker.dart';

class BookResourcePage extends StatefulWidget {
  static final pageName = "BookResourcePage";
  final List<ResourceModel> resources;
  BookResourcePage({this.resources});
  @override
  _BookResourcePageState createState() => _BookResourcePageState();
}

class _BookResourcePageState extends State<BookResourcePage> {
  String date;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text("Book Resource"),
        ),
        body: widget.resources.isNotEmpty
            ? ListView(
                children: [
                  DateTimePicker(
                    dateHintText: "Select Date",
                    type: DateTimePickerType.date,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 30)),
                    onChanged: (selectedDate) {
                      print("on changed called");
                      setState(() {
                        date = selectedDate;
                      });
                    },
                  ),
                  ...widget.resources
                      .map((resource) =>
                          ResourceBookingWidget(resource: resource, date: date))
                      .toList()
                ],
              )
            : Text("sorry, No Resources available now :("));
  }
}
