import 'package:customer249/models/resource_booking_model.dart';
import 'package:customer249/models/resource_model.dart';
import 'package:customer249/models/user_model.dart';
import 'package:customer249/provider/api_services.dart';
import 'package:customer249/utils/parsing.dart';
import 'package:customer249/widgets/Loading_widget.dart';
import 'package:customer249/widgets/error_widgets.dart';
import 'package:customer249/widgets/success_widget.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:customer249/models/api_exception_model.dart' as ApiExceptions;

class ResourceBookingWidget extends StatefulWidget {
  final ResourceModel resource;
  final String date;
  ResourceBookingWidget({this.resource, this.date});
  @override
  _ResourceBookingWidgetState createState() => _ResourceBookingWidgetState();
}

class _ResourceBookingWidgetState extends State<ResourceBookingWidget> {
  List<String> bookinglist = []; // 24 zeros
  List isButtonDiabled = [];
  bool isBookButtonDisabled = true;

  @protected
  @mustCallSuper
  void initState() {
    super.initState();
    for (int i = 0; i < 24; i++) {
      bookinglist.add("0");
      isButtonDiabled.add(false);
    }
  }

  List<Widget> availableTimeSlotsWidget(String schedule) {
    List<Widget> availableTimeSlots = [];
    for (int i = 0; i < 24; i++) {
      if (schedule[i] == '0') availableTimeSlots.add(timeSlotButton(i));
    }
    if (availableTimeSlots.isEmpty)
      availableTimeSlots.add(customText(
          "Sorry, this room is fully booked on ${widget.date}. Please choose another date or search for another room."));
    return availableTimeSlots;
  }

  Widget timeSlotButton(int hour) {
    return FlatButton(
      onPressed: () {
        if (isButtonDiabled[hour]) {
          bookinglist[hour] = '0';
          print("booking : " + bookinglist.join());
          if (countNumberOfHoursBooked(bookinglist.join()) == 0)
            isBookButtonDisabled = true;
        } else {
          isBookButtonDisabled = false;
          bookinglist[hour] = '1';
          print("booking : " + bookinglist.join());
        }
        setState(() {
          isButtonDiabled[hour] = !isButtonDiabled[hour];
        });
      },
      child: Text(hour.toString() + ":00"),
      color: isButtonDiabled[hour] ? Colors.grey : Colors.green,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: height / 4,
        width: width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //room name
                  customText(widget.resource.name),
                  // room capacity
                  customText(
                      "capacity : " + widget.resource.capacity.toString()),
                  // room price per hour
                  customText(
                      widget.resource.pricePerHour.toString() + "  Points/hr"),
                ],
              ),
            ),
            VerticalDivider(
              thickness: 5,
            ),
            //availability
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: widget.date == null
                    ? Center(
                        child: customText(
                            "Please select date to get all available time slots"),
                      )
                    : SingleChildScrollView(
                        child: Center(
                          child: Wrap(
                            runSpacing: 10,
                            spacing: 10,
                            children: [
                              ...availableTimeSlotsWidget(
                                  // only the day of the date
                                  widget.resource.schedule[int.parse(widget.date
                                          .substring(widget.date.length - 2))
                                      .toString()])
                            ],
                          ),
                        ),
                      ),
              ),
            ),
            //book button
            Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlatButton(
                    child: Text("BOOK"),
                    color: Colors.purple,
                    disabledColor: Colors.grey,
                    onPressed: isBookButtonDisabled
                        ? null
                        : () {
                            print("pressed by : " + widget.resource.name);
                            // calculate total number of hours booked , total price
                            int numberOfHoursBooked =
                                countNumberOfHoursBooked(bookinglist.join());
                            num totalPrice = numberOfHoursBooked *
                                widget.resource.pricePerHour;
                            ResourceModel resource = widget.resource;
                            //
                            ResourceBookingModel resourceBookingModel =
                                ResourceBookingModel(
                                    resource: resource,
                                    totalNumberOfHoursBooked:
                                        numberOfHoursBooked,
                                    totalPrice: totalPrice,
                                    date: widget.date,
                                    bookedFor: bookinglist.join(),
                                    isPending: true,
                                    isConfirmed: false,
                                    isRejected: false);
                            //
                            showConfirmBookingDialog(context,
                                booking: resourceBookingModel);
                          },
                  ),
                ))
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[300],
          boxShadow: [
            BoxShadow(
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
      ),
    );
  }
  // confirm booking alert dialog

  Future showConfirmBookingDialog(context, {ResourceBookingModel booking}) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
              title: Text("confirm booking"),
              content: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      showBottomBorder: true,
                      columns: [
                        DataColumn(label: tableColoumnscustomText("Room Name")),
                        DataColumn(
                            label: tableColoumnscustomText("Room Capacity")),
                        DataColumn(
                            label: tableColoumnscustomText("Booking Date")),
                        DataColumn(
                            label:
                                tableColoumnscustomText("Room Price Per Hour")),
                        DataColumn(
                            label:
                                tableColoumnscustomText("Total hours booked")),
                        DataColumn(
                            label: tableColoumnscustomText("Total Price")),
                      ],
                      rows: [
                        DataRow(cells: [
                          DataCell(Center(
                              child: customText("${booking.resource.name}"))),
                          DataCell(Center(
                              child:
                                  customText("${booking.resource.capacity}"))),
                          DataCell(
                              Center(child: customText("${booking.date}"))),
                          DataCell(Center(
                              child: customText(
                                  "${booking.resource.pricePerHour}"))),
                          DataCell(Center(
                              child: customText(
                                  "${booking.totalNumberOfHoursBooked}"))),
                          DataCell(Center(
                              child: customText("${booking.totalPrice}")))
                        ])
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      Text("Booked for : "),
                      ...parseBookingTimeTableToWidgets(booking.bookedFor)
                    ],
                  )
                ],
              ),
              actions: [
                FlatButton(
                    onPressed: (() async {
                      bookResource(context, booking);
                    }),
                    color: Colors.green,
                    child: Text("confirm")),
                FlatButton(
                    onPressed: (() {
                      Navigator.pop(context);
                    }),
                    color: Colors.red,
                    child: Text("Cancel"))
              ],
            ));
  }

  Text customText(String text) {
    return Text(
      text,
      textScaleFactor: 1.0,
      style: TextStyle(fontWeight: FontWeight.w400),
    );
  }

  Text tableColoumnscustomText(String text) {
    return Text(
      text,
      textScaleFactor: 1.2,
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }

  int countNumberOfHoursBooked(String booking) {
    int counter = 0;
    for (int i = 0; i < booking.length; i++) {
      if (booking[i] == "1") counter++;
    }
    return counter;
  }

  Future<void> bookResource(
      context, ResourceBookingModel resourceBookingModel) async {
    try {
      showLoadingDialog(context);
      await Provider.of<ApiService>(context, listen: false)
          .bookResource(resourceBookingModel);
      UserModel.user.points -= resourceBookingModel.totalPrice;
      Navigator.pop(context);
      showSuccessWidget(context,
          "booking request has been successfully made, you can monitor the status of your booking requests in the 'manage bookings' page");
    } on ApiExceptions.InsufficientPoints catch (e) {
      Navigator.pop(context);
      showErrorWidget(context, "insufficiant funds , Please recharge");
    } on ApiExceptions.RoomUnavailable catch (e) {
      Navigator.pop(context);
      showErrorWidget(
          context, "Sorry, this room is not available at this time");
    } catch (e) {
      Navigator.pop(context);
      showErrorWidget(context, "Somthing went wrong");
    }
  }
}
