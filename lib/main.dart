import 'package:coffee_shop/app/app.dart';
import 'package:coffee_shop/app/injector/injector.dart';

import 'package:flutter/material.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}
