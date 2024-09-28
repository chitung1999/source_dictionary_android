import 'package:flutter/cupertino.dart';
import '../common/enum.dart';

class ConfigApp {
  String username = '';
  String password = '';
  ThemeApp theme = ThemeApp.LIGHT;
  final Container banner = Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xff355C7D), Color(0xff6C5B7B), Color(0xffC06C84)],
        stops: [0, 0.5, 1],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
    ),
  );

  void loadData(Map<String, dynamic> data) {
    username = data["username"];
    password = data["password"];
    theme = data["theme"] == 1 ? ThemeApp.LIGHT : ThemeApp.DARK;
  }
}