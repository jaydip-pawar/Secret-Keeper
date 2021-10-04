import 'package:flutter/material.dart';

class SyncAndBackup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Image.asset('assets/images/cloud.png')
          ],
        ),
      )
    );
  }
}
