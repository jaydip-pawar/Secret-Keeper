import 'package:flutter/material.dart';

class AddWebsite extends StatefulWidget {
  @override
  _AddWebsiteState createState() => _AddWebsiteState();
}

class _AddWebsiteState extends State<AddWebsite> {

  Icon cusIcon = Icon(Icons.search);

  Widget cusSearchBar = Row(children: [
    Text(
      "Add Website",
    ),
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: cusSearchBar,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (this.cusIcon.icon == Icons.search) {
                  this.cusIcon = Icon(Icons.cancel, color: Colors.black87);
                  this.cusSearchBar = Container(
                    height: 50,
                    child: TextField(
                      textInputAction: TextInputAction.go,
                      autofocus: true,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: "Search here"),
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  );
                } else {
                  this.cusIcon = Icon(Icons.search);
                  this.cusSearchBar = Row(children: [
                    Text(
                      "SECRET",
                      style: TextStyle(
                          color: Colors.orange[900],
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "KEEPER",
                      style: TextStyle(
                          color: Colors.black87, fontWeight: FontWeight.w700),
                    ),
                  ]);
                }
              });
            },
            icon: cusIcon,
          ),
        ],
      ),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
