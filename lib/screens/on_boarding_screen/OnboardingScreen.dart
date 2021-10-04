import 'dart:io';

import 'package:flutter/material.dart';
import 'package:secret_keeper/screens/lock_screen/get_password.dart';
import 'package:secret_keeper/screens/on_boarding_screen/data/data.dart';


class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  List<SliderModel> mySlides = new List<SliderModel>();
  int slideIndex = 0;
  PageController controller;

  Widget _buildPageIndicator(bool isCurrentPage){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentPage ? 10.0 : 6.0,
      width: isCurrentPage ? 10.0 : 6.0,
      decoration: BoxDecoration(
        color: isCurrentPage ? Colors.grey : Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mySlides = getSlides();
    controller = new PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [const Color(0xFF9E9E9E), const Color(0xFFE0E0E0)])),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            height: MediaQuery.of(context).size.height - 50,
            child: PageView(
              controller: controller,
              onPageChanged: (index) {
                setState(() {
                  slideIndex = index;
                });
              },
              children: <Widget>[
                SlideTile(
                  imagePath: mySlides[0].getImageAssetPath(),
                  title: mySlides[0].getTitle(),
                  desc: mySlides[0].getDesc(),
                ),
                SlideTile(
                  imagePath: mySlides[1].getImageAssetPath(),
                  title: mySlides[1].getTitle(),
                  desc: mySlides[1].getDesc(),
                ),
                SlideTile(
                  imagePath: mySlides[2].getImageAssetPath(),
                  title: mySlides[2].getTitle(),
                  desc: mySlides[2].getDesc(),
                )
              ],
            ),
          ),
          bottomSheet: slideIndex != 2 ? Container(
            margin: EdgeInsets.symmetric(vertical: 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton(
                  onPressed: (){
                    controller.animateToPage(2, duration: Duration(milliseconds: 400), curve: Curves.linear);
                  },
                  splashColor: Colors.white,
                  child: Text(
                    "SKIP",
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      for (int i = 0; i < 3 ; i++) i == slideIndex ? _buildPageIndicator(true): _buildPageIndicator(false),
                    ],),
                ),
                FlatButton(
                  onPressed: (){
                    print("this is slideIndex: $slideIndex");
                    controller.animateToPage(slideIndex + 1, duration: Duration(milliseconds: 500), curve: Curves.linear);
                  },
                  splashColor: Colors.white,
                  child: Text(
                    "NEXT",
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ): InkWell(
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => GetPassword()));
            },
            child: Container(
              height: Platform.isIOS ? 60 : 50,
              color: Colors.deepOrange,
              alignment: Alignment.center,
              child: Text(
                "GET STARTED NOW",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SlideTile extends StatelessWidget {
  final String imagePath, title, desc;

  SlideTile({this.imagePath, this.title, this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(imagePath),
          SizedBox(
            height: 40,
          ),
          Text(title, textAlign: TextAlign.center,style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20
          ),),
          SizedBox(
            height: 20,
          ),
          Text(desc, textAlign: TextAlign.center,style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14))
        ],
      ),
    );
  }
}
