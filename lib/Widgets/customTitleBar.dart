import 'package:flutter/material.dart';

class cusTitleBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "SECRET",
          style: TextStyle(color: Colors.orange[900], fontWeight: FontWeight.w700),
        ),
        Text(
          "KEEPER",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
