import 'package:film_update_mobile_apps/utils/network_connectivity/depedency_injection.dart';
import 'package:flutter/material.dart';

import 'my_app.dart';

void main() async {
  runApp(const MyApp());
  DepedencyInjection.init();
}
