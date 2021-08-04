import 'dart:ffi';

class ResourceModel {
  num id;
  String name;
  String service; //TOOD: maybe this is a model as well
  num capacity;
  num pricePerHour;
  bool isActive;
  static List<ResourceModel> allResources = [];
  ResourceModel(
      {this.id,
      this.name,
      this.service,
      this.capacity,
      this.pricePerHour,
      this.isActive});

  ResourceModel.fromJson(Map<String, dynamic> json)
      : this.id = json['id'],
        this.name = json["name"],
        this.service = json["service"],
        this.capacity = json["capacity"],
        this.pricePerHour = json['price_per_hour'],
        this.isActive = json['is_active'];
}
