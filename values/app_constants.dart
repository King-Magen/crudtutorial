import 'package:flutter/material.dart';

class AppConstants {
  AppConstants._();

  static final navigationKey = GlobalKey<NavigatorState>();

  static final RegExp emailRegex = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.([a-zA-Z]{2,})+",
  );

  static final RegExp passwordRegex = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$#!%*?&_])[A-Za-z\d@#$!%*?&_].{7,}$',
  );

  static const String _baseUrl = "http://127.0.0.1:5000";
  static const String usersUrl = "$_baseUrl/api/users";
  static const String authUrl = "$_baseUrl/api/auth/login";

  final headerStyle = TextStyle(fontSize: 22, fontWeight: FontWeight.bold);
  final titleStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
  final titleStyle2 = TextStyle(fontSize: 16, color: Colors.black45);
  final subtitleStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
  final infoStyle = TextStyle(fontSize: 12, color: Colors.black54);

  //Decoration
  final roundedRectangle12 = RoundedRectangleBorder(
    borderRadius: BorderRadiusDirectional.circular(12),
  );

  final roundedRectangle4 = RoundedRectangleBorder(
    borderRadius: BorderRadiusDirectional.circular(4),
  );

  final roundedRectangle40 = RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
  );
}
