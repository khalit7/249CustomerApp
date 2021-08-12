class ResourceBookingModel {
  String resourceName;
  int resourceId;
  int resourceCapacity;
  num resourcePricePerHour;
  int totalNumberOfHoursBooked;
  num totalPrice;
  String date;
  String bookedFor;
  ResourceBookingModel(
      {this.resourceName,
      this.resourceId,
      this.resourceCapacity,
      this.resourcePricePerHour,
      this.totalNumberOfHoursBooked,
      this.totalPrice,
      this.date,
      this.bookedFor});
  ResourceBookingModel.fromJson(Map<String, dynamic> json)
      : this.resourceName = json[''],
        this.resourceId = json[''],
        this.resourceCapacity = json[''],
        this.resourcePricePerHour = json[''],
        this.totalNumberOfHoursBooked = json[''],
        this.totalPrice = json[''],
        this.date = json[''],
        this.bookedFor = json[''];
}
