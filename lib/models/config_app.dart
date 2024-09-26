import '../common/enum.dart';

class ConfigApp {
  String username = '';
  String password = '';
  ThemeApp theme = ThemeApp.LIGHT;

  void loadData(Map<String, dynamic> data) {
    username = data["username"];
    password = data["password"];
    theme = data["theme"] == 1 ? ThemeApp.LIGHT : ThemeApp.DARK;
  }
}