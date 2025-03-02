import 'package:crudtutorial/widgets/dashboard.dart';
import 'package:crudtutorial/screens/navigation.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              // default flex = 1 and it takes 1/6 part of the screen
              child: Navigation(),
          ),
          Expanded(
            flex: 5,
            child: DashboardScreen(),
          ),
        ],
      ),
    ));
  }
}

