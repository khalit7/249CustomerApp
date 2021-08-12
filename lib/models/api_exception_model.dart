import 'package:dio/dio.dart';

class BaseException implements Exception {}

class InvalidToken extends BaseException {
  final String message;

  InvalidToken({this.message});
}

class UserExists extends BaseException {}

class UserDosNotExists extends BaseException {}

class ServiceUnavailable extends BaseException {}

class InsufficientPoints extends BaseException {}

class RoomUnavailable extends BaseException {}

class Unknown extends BaseException {
  final String message;
  final int statusCode;
  final String errorKey;
  final String title;

  Unknown({this.message, this.statusCode, this.errorKey, this.title});
}

BaseException parseResponse(Response response) {
  final data = response.data;
  if (data is Map<String, dynamic>) {
    return parseAPIResponseJson(data);
  }
  switch (response.statusCode) {
    case 503:
      return ServiceUnavailable();
    default:
      return Unknown(message: data, statusCode: response.statusCode);
  }
}

BaseException parseErrorString(error) {
  switch (error) {
    case "Unauthorized":
      return UserDosNotExists();
    case "insufficient_points":
      return InsufficientPoints();
    case "room_unavailable":
      return RoomUnavailable();
  }
}

BaseException parseAPIResponseJson(json) {
  switch (json["errorKey"]) {
    case "idexists":
      return UserExists();
    case "noid":
      return UserDosNotExists();
    default:
      return Unknown(
        message: json["message"],
        statusCode: json["status"],
        errorKey: json["errorKey"],
        title: json["title"],
      );
  }
}
