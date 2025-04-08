import 'package:shared_preferences/shared_preferences.dart';

// Function to save the login state
Future<void> savePlayerLoginState(bool isLoggedIn) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isPlayerLoggedIn', isLoggedIn);
}

Future<void> saveAdminLoginState(bool isLoggedIn) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isAdminLoggedIn', isLoggedIn);
}

Future<void> saveAdminEmail(String adminEmail) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('adminEmail', adminEmail);
}

Future<void> savePlayerEmail(String playerEmail) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('playerEmail', playerEmail);
}

Future<void> savePlayerId(String id) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('playerId', id);
}

Future<void> saveAdminId(String id) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('adminId', id);
}

Future<void> saveAdminType(String adminType) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('adminType', adminType);
}

// Function to retrieve the login state
Future<bool> getPlayerLoginState() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isPlayerLoggedIn') ??
      false; // Defaults to false if not set
}

Future<bool> getAdminLoginState() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isAdminLoggedIn') ??
      false; // Defaults to false if not set
}

Future<String?> getplayerId() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('playerId');
}

Future<String?> getAdminId() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('adminId');
}

Future<String?> getAdminEmail() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('adminEmail');
}

Future<String?> getPlayerEmail() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('playerEmail');
}

Future<String?> getAdminType() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('adminType');
}
