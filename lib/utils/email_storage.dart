import 'package:shared_preferences/shared_preferences.dart';


Future<void> saveEmail(String email) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('email', email);
}

Future<String> getEmail() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('email') ?? '';
}