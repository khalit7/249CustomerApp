import 'dart:ffi';

class ResourceModel {
  num id;
  String name;
  String service; //TOOD: maybe this is a model as well
  num capacity;
  num pricePerHour;
  Map schedule;

  static List<ResourceModel> allResources = [];
  ResourceModel({
    this.id,
    this.name,
    this.service,
    this.capacity,
    this.pricePerHour,
    this.schedule,
  });

  ResourceModel.fromJson(Map<String, dynamic> json)
      : this.id = json['id'],
        this.name = json["name"],
        this.service = json["service"],
        this.capacity = json["capacity"],
        this.pricePerHour = json['price_per_hour'],
        this.schedule = json['availability'];
}
