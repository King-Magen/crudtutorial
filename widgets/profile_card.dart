import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5/2),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 128, 201, 135),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white10)
      ),
      child: Row( 
        children: [
          Image.asset(
            "assets/logos/logo.png",
            height: 38,
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal:20 / 2, vertical: 10),
              child: Text("Angelina Jolie"), 
          ),
          Icon(Icons.keyboard_arrow_down)
        ],
      ),
    );
  }
}