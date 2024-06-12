import 'enum_app.dart';

class ConfigApp {
  ConfigApp._internal();
  factory ConfigApp() {return _instance;}
  static final ConfigApp _instance = ConfigApp._internal();

  String username = '';
  String password = '';
  ThemeApp theme = ThemeApp.light;

  void loadData(Map<String, dynamic> data) {
    username = data["username"];
    password = data["password"];
    theme = data["theme"] == 1 ? ThemeApp.light : ThemeApp.dark;
  }
}