import 'package:flutter/material.dart';

import 'package:customer249/provider/api_services.dart';
import 'customer_app.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(
      Provider<ApiService>(create: (context) => ApiService(), child: MyApp()));
}
