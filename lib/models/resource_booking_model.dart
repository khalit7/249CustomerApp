import 'package:customer249/models/resource_model.dart';

class ResourceBookingModel {
  ResourceModel resource;
  int totalNumberOfHoursBooked;
  num totalPrice;
  String date;
  String bookedFor;
  bool isPending;
  bool isConfirmed;
  bool isRejected;
  ResourceBookingModel(
      {this.resource,
      this.totalNumberOfHoursBooked,
      this.totalPrice,
      this.date,
      this.bookedFor,
      this.isPending,
      this.isConfirmed,
      this.isRejected});
  ResourceBookingModel.fromJson(Map<String, dynamic> json)
      : this.resource = ResourceModel.fromJson(json['resource']),
        this.totalNumberOfHoursBooked = json['total_number_of_hours'],
        this.totalPrice = json['total_cost'],
        this.date = json['booking_date'],
        this.bookedFor = json['booked_for'],
        this.isPending = json['is_pending'],
        this.isConfirmed = json['is_confirmed'],
        this.isRejected = json['is_rejected'];
}
