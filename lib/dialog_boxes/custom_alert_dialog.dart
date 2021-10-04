import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final title, content, btnText;

  const CustomAlertDialog({Key key, this.title, this.content, this.btnText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.only(top: 25.0),
      title: Center(
        child: Text(title),
      ),
      elevation: 10,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
            child: Text(
              content,
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
                  btnText,
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
