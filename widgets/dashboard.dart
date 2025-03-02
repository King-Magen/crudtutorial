import 'package:crudtutorial/screens/home_page.dart';
import 'package:crudtutorial/widgets/header.dart';
import 'package:flutter/material.dart'; 

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(children: [
            Header(),
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    height: 500,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: HomePage(),
                  ),
                ),
                SizedBox(width: 5,),
                // Expanded(
                //   flex: 2,
                //   child: Container(
                //     height: 500,
                //     decoration: BoxDecoration(
                //       color: Colors.red,
                //       borderRadius: BorderRadius.all(Radius.circular(10)),
                //     ),
                //   ),
                // ),
              ],
            ),
          ])),
    );
  }
}


