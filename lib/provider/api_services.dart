import 'dart:io';

import 'package:customer249/models/resource_booking_model.dart';
import 'package:customer249/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:customer249/utils/constants.dart';

import 'package:customer249/models/resource_model.dart';
import 'package:flutter/cupertino.dart';

import 'package:customer249/models/api_exception_model.dart' as ApiExceptions;

class ApiService {
  String _jwtToken;
  final dio = Dio(BaseOptions(
      baseUrl: Constants.API_BASE_URL,
      contentType: Headers.jsonContentType,
      headers: {HttpHeaders.acceptHeader: Headers.jsonContentType},
      connectTimeout: 45 * 1000, // 45 seconds
      receiveTimeout: 45 * 1000));

  //
  Future<List<ResourceModel>> checkResourceAvailability(
      int capacity, String resourceService) async {
    String endpoint = "booking/checkAvailability/";
    Map data = {'capacity': capacity, 'service': resourceService};
    Response response = await dio.post(endpoint, data: data);
    List<ResourceModel> allAvailableResources = response
        .data['resources availability']
        .map<ResourceModel>(
            (resourceJson) => ResourceModel.fromJson(resourceJson))
        .toList();
    return allAvailableResources;
  }

  Future<void> getAllResources() async {
    String endpoint = "booking/allResources/";
    Response response = await dio.get(endpoint);
    List<ResourceModel> allResources = response.data
        .map<ResourceModel>(
            (resourceJson) => ResourceModel.fromJson(resourceJson))
        .toList();
    ResourceModel.allResources = allResources;
  }

  Future<String> login(String email, String password) async {
    String endpoint = "users/login/";
    Map data = {"email": "$email", "password": "$password"};
    try {
      Response response = await dio.post(endpoint, data: data);
      _jwtToken = response.data['access'];
      // add dio intercepter
      addJwtIntercepter(_jwtToken);
      return _jwtToken;
    } on DioError catch (e) {
      print(e);
      throw ApiExceptions.parseErrorString(e.response.statusMessage);
    }
  }

  Future<void> bookResource(ResourceBookingModel resourceBookingModel) async {
    String endpoint = "booking/book/";
    Map data = {
      "resource": resourceBookingModel.resourceId,
      "booking_date": resourceBookingModel.date,
      "booked_for": resourceBookingModel.bookedFor
    };
    try {
      Response response = await dio.post(endpoint, data: data);
    } on DioError catch (e) {
      throw ApiExceptions.parseErrorString(e.response.data['response message']);
    }
  }

  Future<void> logOut() async {
    // remove the dio intercepter
    dio.interceptors.removeLast();
    UserModel.user = null;
  }

  Future<UserModel> getUser() async {
    final response = await dio.get('users/me/');
    UserModel.user = UserModel.fromJson(response.data);
    return UserModel.user;
  }

  ////////////////////

  void addJwtIntercepter(jwtToken) {
    dio.interceptors.add(_JwtInterceptor(dio: dio, jwt: jwtToken));
  }
}

class _JwtInterceptor extends Interceptor {
  Dio dio;
  String jwt;
  _JwtInterceptor({@required this.dio, this.jwt});

  Future<RequestOptions> onRequest(options) async {
    // Add Bearer Authorization HTTP header if needed

    options.headers
        .putIfAbsent(HttpHeaders.authorizationHeader, () => "Bearer $jwt");

    return options;
  }
}
