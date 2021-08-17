import 'package:flutter/material.dart';

List<Widget> parseBookingTimeTableToWidgets(String bookedFor) {
  List<Widget> returnValue = [];
  List<String> bookedTimes = [];
  // get booked times array
  for (int i = 0; i < bookedFor.length; i++) {
    if (bookedFor[i] == '1') {
      bookedTimes.add(i.toString() + ":00 - " + (i + 1).toString() + ":00");
    }
  }
  // create the widgets
  for (int i = 0; i < bookedTimes.length; i++) {
    Widget timeSlot = Container(
      child: Text(
        bookedTimes[i],
        textScaleFactor: 1.3,
      ),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
    );
    returnValue.add(timeSlot);
  }
  return returnValue;
}
