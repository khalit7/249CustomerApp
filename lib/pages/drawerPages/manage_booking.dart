import 'dart:core';
import 'package:customer249/models/resource_booking_model.dart';
import 'package:customer249/utils/parsing.dart';
import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';

class ManageBookingPage extends StatefulWidget {
  static final pageName = "ManageBookingPage";
  final List<ResourceBookingModel> bookingsList;
  ManageBookingPage({this.bookingsList});

  @override
  _ManageBookingPageState createState() => _ManageBookingPageState();
}

class _ManageBookingPageState extends State<ManageBookingPage> {
  TextEditingController dateController;
  String selectedDate = "";
  List<ResourceBookingModel> displayedBookings;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    displayedBookings = widget.bookingsList;
  }

  void displayBookingDetails(ResourceBookingModel transaction) {
    // if (!transaction.isSuccessful) return;
    // Map _pageDetails = {};
    // if (transaction.pan != null) _pageDetails["Card Number"] = transaction.pan;
    // if (transaction.date != null)
    //   _pageDetails["Date"] = DateFormat.yMd().format(transaction.date);
    // if (transaction.number != null) _pageDetails["number"] = transaction.number;
    // if (transaction.comment != null)
    //   _pageDetails["Comment"] = transaction.comment;
    // if (transaction.voucherCode != null)
    //   _pageDetails["Voucher Code"] = transaction.voucherCode;
    // if (transaction.reciverCard != null)
    //   _pageDetails["To Card"] = concealCardNumber(transaction.reciverCard);
    // if (transaction.customerName != null)
    //   _pageDetails["customer Name"] = transaction.customerName;
    // if (transaction.token != null) _pageDetails["token"] = transaction.token;
    // if (transaction.meterNumber != null)
    //   _pageDetails["Meter Number"] = transaction.meterNumber;
    // if (transaction.waterFees != null)
    //   _pageDetails["water Fees"] = transaction.waterFees;
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => TransactionReceipt(
    //               subTitle: transaction.type,
    //               transactionValue: beautifyTransactionAmount(
    //                   transaction.transactionAmount.toString()),
    //               pageDetails: _pageDetails,
    //             )));
  }

  build(context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
          title: Text(
        "Bookings",
      )),
      body: widget.bookingsList.isEmpty
          ? Center(
              child: Text("you haven't made any bookings yet"),
            )
          : Column(
              children: [
                ListTile(
                  title: Text("filter by date"),
                  trailing: Text(selectedDate),
                  onTap: () {
                    _selectDate(context);
                  },
                ),
                Expanded(
                  child: ListView(
                    children: displayedBookings
                        .map((booking) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Material(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                elevation: 2,
                                child: ListTile(
                                  leading: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      getBookingIcon(booking),
                                    ],
                                  ),
                                  title: Text(booking.resource.service),
                                  subtitle: Text(
                                    booking.resource.name +
                                        "\n" +
                                        "${booking.date}",
                                  ),
                                  isThreeLine: true,
                                  trailing: _bookingStatusWidget(
                                      booking, width, height),
                                  onTap: () {
                                    showBookingDetailsDialog(context,
                                        booking: booking);
                                  },
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                )
              ],
            ),
    );
  }

  Icon getBookingIcon(ResourceBookingModel booking) {
    IconData icon;
    switch (booking.resource.service) {
      case "meeting":
        icon = Icons.meeting_room;
        break;
      default:
        icon = Icons.ac_unit;
    }

    return Icon(icon);
  }

  Widget _bookingStatusWidget(
      ResourceBookingModel booking, var width, var height) {
    String status;
    Color color;
    if (booking.isPending) {
      status = "Pending";
      color = Colors.yellow;
    } else if (booking.isConfirmed) {
      status = "Confirmed";
      color = Colors.green;
    } else if (booking.isRejected) {
      status = "Rejected";
      color = Colors.red;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: width / 4,
          child: Center(child: Text("$status")),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: color),
        )
      ],
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2200));
    if (pickedDate != null)
      setState(() {
        selectedDate = DateFormat.yMd().format(pickedDate);
        _filterarray(pickedDate);
      });
  }

  bool _isTheSameDate(DateTime date1, DateTime date2) {
    if ((date1.year == date2.year) &&
        (date1.month == date2.month) &&
        (date1.day == date2.day))
      return true;
    else
      return false;
  }

  _filterarray(DateTime date) {
    displayedBookings = widget.bookingsList;
    displayedBookings = displayedBookings
        .where((booking) => _isTheSameDate(DateTime.parse(booking.date), date))
        .toList();
  }

  Future showBookingDetailsDialog(context, {ResourceBookingModel booking}) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
              title: Text("Booking Details"),
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
                    onPressed: (() {
                      Navigator.pop(context);
                    }),
                    color: Colors.purple,
                    child: Text("OK")),
              ],
            ));
  }

  Text tableColoumnscustomText(String text) {
    return Text(
      text,
      textScaleFactor: 1.2,
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Text customText(String text) {
    return Text(
      text,
      textScaleFactor: 1.2,
      style: TextStyle(fontWeight: FontWeight.w400),
    );
  }
}
