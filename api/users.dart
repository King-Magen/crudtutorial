import 'package:http/http.dart' as http;
import 'package:crudtutorial/values/app_constants.dart';
import 'dart:convert';

class ApiService {
  static Future<Map<String, dynamic>> createUser(
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

  static Future<List<Map<String, dynamic>>> getAllUsers() async {
    try {
      final response = await http.get(Uri.parse(AppConstants.usersUrl));

      final List<dynamic> data = jsonDecode(response.body); 
      return List<Map<String, dynamic>>.from(data);
    } catch (e) {
      throw Exception("Failed to load user data: $e");
    }
  }
}
