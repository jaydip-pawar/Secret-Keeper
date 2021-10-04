import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:secret_keeper/Database/Moor/moor_database.dart';
import 'package:secret_keeper/screens/SplashScreen.dart';
import 'package:wiredash/wiredash.dart';

void main() async{
  // var urls = [
  //   'https://www.aftonbladet.se',
  //   'https://www.braziltravelblog.com',
  //   'https://www.mashable.com',
  //   'https://tradevenue.se/miljonarinnan30',
  //   'https://github.com/',
  //   'https://www.businessinsider.com/',
  //   'https://www.mrmoneymustache.com/',
  //   'https://thedividendstory.com/',
  //   'http://dailybeast.com',
  //   'https://www.traveldailynews.com/',
  //   'https://www.tenable.com/blog-rss',
  //   'http://blog.tenablesecurity.com/atom.xml', // Should fail and yield null
  //   'https://hbr.org/',
  //   'http://benfrain.com/',
  //   'http://www.alistapart.com',
  //   'https://fortune.com/',
  //   'https://tidochpengar.se/'
  // ];
  //
  // for (var url in urls) {
  //   print(url);
  //   print(await Favicon.getBest(url));
  //   print('');
  // }
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    Phoenix(
      child: SecretKeeper(),
    )
  );
}

class SecretKeeper extends StatefulWidget {

  @override
  _SecretKeeperState createState() => _SecretKeeperState();
}

class _SecretKeeperState extends State<SecretKeeper> {
  String _projectID = "secret_keeper-ldsrrw2";

  String _secretKey = "p36c0lxyv6ehkel8193t2sm7v0j9thse4htu7f76epw9helu";

  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    final db = AppDatabase();
    return Wiredash(
      projectId: _projectID,
      secret: _secretKey,
      navigatorKey: _navigatorKey,
      theme: WiredashThemeData(
        primaryColor: Colors.orange,
        secondaryColor: Colors.orangeAccent.shade200
      ),
      child: MultiProvider(
        providers: [
          Provider(builder: (_) => db.passwordDao),
          Provider(builder: (_) => db.cardDetailDao),
          Provider(builder: (_) => db.bankDao),
          Provider(builder: (_) => db.noteDao),
        ],
        child: MaterialApp(
          navigatorKey: _navigatorKey,
          title: "Secret Keeper",
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            accentColor: Colors.black12,
            primaryColor: Colors.white,
            snackBarTheme: SnackBarThemeData(behavior: SnackBarBehavior.floating),
            floatingActionButtonTheme: FloatingActionButtonThemeData(foregroundColor: Colors.black87),
            primaryIconTheme: IconThemeData(color: Colors.black),
            fontFamily: "GoogleFonts",
          ),
          home: SplashScreen(),
        ),
      ),
    );
  }
}
