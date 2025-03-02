import 'package:crudtutorial/widgets/profile_card.dart';
import 'package:crudtutorial/widgets/search_field.dart';
import 'package:flutter/material.dart'; 

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Dashboard",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Spacer(flex: 2),
        Expanded(
          child: SearchField(),
        ),
        ProfileCard(),
      ],
    );
  }
} 