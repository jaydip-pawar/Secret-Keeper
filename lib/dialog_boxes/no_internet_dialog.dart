import 'package:flutter/material.dart';

class NoInternetDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 10,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            child: Image.asset(
              "assets/images/no_internet.jpg",
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.8,
            ),
          ),
          Container(
            child: Text("No internet connection",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold
            ),),
          ),
          SizedBox(height: 15,),
          Container(
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
            child: Text(
              "Make sure Wi-Fi or mobile data is turned on, then try again",
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Divider(
            height: 1,
          ),
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
              ),
              child: Container(
                alignment: Alignment.center,
                constraints:
                BoxConstraints(maxWidth: double.infinity, minHeight: 50),
                child: Text(
                  "Retry",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
