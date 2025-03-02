import 'package:crudtutorial/utils/shared_pref_utils.dart';
import 'package:crudtutorial/widgets/drawer_list_tile.dart';
import 'package:flutter/material.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  void _clearSharedPreferences() {
    setState(() {
      SharedPrefUtils.clearAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Row(
        children: [
          Expanded(
              // default flex = 1 and it takes 1/6 part of the screen
              child: Drawer(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  DrawerHeader(
                    child: Image.asset("assets/logos/logo.png"),
                  ),
                  DrawerListTile(
                      title: "Dashboard",
                      svgSrc: "assets/icons/dashboard-svgrepo-com.svg",
                      press: () {}),
                  DrawerListTile(
                      title: "Request",
                      svgSrc: "assets/icons/req-svgrepo-com.svg",
                      press: () {}),
                  DrawerListTile(
                      title: "Logout",
                      svgSrc: "assets/icons/logout-svgrepo-com.svg",
                      press: () {
                        _clearSharedPreferences();
                      })
                ],
              ),
            ),
          )),
        ],
      ),
    ));
  }
}
