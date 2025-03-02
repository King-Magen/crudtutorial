import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          hintText: "Search",
          fillColor: Colors.amber,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius:
                const BorderRadius.all(Radius.circular(10)),
          ),
          suffixIcon: InkWell(
            onTap: () {},
            child: SizedBox(
              width: 1,
              child: Container(
                  padding: EdgeInsets.all(5 * 0.75),
                  margin: EdgeInsets.symmetric(horizontal: 5 / 2),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius:
                        const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: SvgPicture.asset(
                    height: 5,
                    "assets/icons/building-svgrepo-com.svg",
                  )),
            ),
          )),
    );
  }
}