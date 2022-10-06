import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie/app/config/app_module.dart';
import 'package:movie/app/config/app_widget.dart';

void main() {
  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}
