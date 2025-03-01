import 'package:http/http.dart' as http;
import 'package:crudtutorial/values/app_constants.dart';
import 'dart:convert';

class ApiService {
  static Future<Map<String, dynamic>> registerUser(
      int idnumber,
      String password,
      String permission,
      String name,
      String middlename,
      String lastname,
      String position,
      String address,
      String number) async {
    final response = await http.post(
      Uri.parse(AppConstants.usersUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "idnumber": idnumber,
        "password": password,
        "permission": permission,
        "name": name,
        "middlename": middlename,
        "lastname": lastname,
        "position": position,
        "address": address,
        "number": number
      }),
    );

    return jsonDecode(response.body);
  }

  static loginUser(int idnumber, String password) async {
    try {
      final loginUserres = await http.post(
        Uri.parse(AppConstants.authUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "idnumber": idnumber,
          "password": password,
        }),
      );
      var data = jsonDecode(loginUserres.body);
      return data;
    } catch (e) {
      print('Request failed: $e');
    }
  }

  static Future<Map<String, dynamic>> getAllUsers() async {
    final response = await http.get(Uri.parse(AppConstants.usersUrl));
    if (response.statusCode == 200) {
      // final List<dynamic> usersJson = jsonDecode(response.body)['data'];
    } else {
      throw Exception(
          "Failed to load users. Status Code: ${response.statusCode}");
    }

    return jsonDecode(response.body);
  }
}
