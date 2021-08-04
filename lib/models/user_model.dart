import 'dart:ffi';

class UserModel {
  String username;
  String email;
  String dateJoined;
  String role;
  num points;
  String customerRole;
  static UserModel user;
  UserModel(
      {this.username,
      this.email,
      this.dateJoined,
      this.role,
      this.points,
      this.customerRole});

  UserModel.fromJson(Map<String, dynamic> json)
      : this.username = json['username'],
        this.email = json["email"],
        this.dateJoined = json["date_joined"],
        this.role = json["role"],
        this.points = json['points'],
        this.customerRole = json['customer_role'];
}

/*
{
  "username": "khalidCustomer1",
  "email": "khalidsulman1@gmail.com",
  "date_joined": "2021-08-03T11:18:13.479350Z",
  "role": "Customer",
  "points": 1150.0,
  "customer role": "developer"
}
*/
