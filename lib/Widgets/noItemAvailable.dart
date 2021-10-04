import 'dart:ui';

import 'package:flutter/material.dart';

class NoItemAvailable extends StatelessWidget {
  final String image, heading, description;

  const NoItemAvailable({Key key, this.image, this.heading, this.description}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.4;
    double width = MediaQuery.of(context).size.width * 0.7;
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0, bottom: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.width * 0.7,
            cacheHeight: (MediaQuery.of(context).size.width * 0.7).round() * window.devicePixelRatio.ceil(),
            cacheWidth: (MediaQuery.of(context).size.width * 0.7).round() * window.devicePixelRatio.ceil(),
          ),
          Text(
            heading,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.grey
            ),
          ),
        ],
      ),
    );
  }
}
