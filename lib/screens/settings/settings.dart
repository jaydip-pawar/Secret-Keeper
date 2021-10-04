import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:secret_keeper/app_settings.dart';
import 'package:secret_keeper/dialog_boxes/auto_lock_dialog.dart';
import 'package:secret_keeper/main.dart';
import 'package:secret_keeper/screens/settings/auto_lock.dart';
import 'package:secret_keeper/screens/settings/privacy_policy.dart';
import 'package:secret_keeper/screens/settings/sync_and_backup.dart';
import 'package:secret_keeper/screens/settings/change_master_password.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:local_auth/local_auth.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'package:wiredash/wiredash.dart';

class SettingsPage extends StatefulWidget {
  final bool isFingerprintEnabled;

  const SettingsPage({Key key, this.isFingerprintEnabled}) : super(key: key);
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  MyAppSettings settings;

  bool _isFingerprintEnabled, _isFingerprintAvail = false, _isAutoFill = false, _isAutoLocking = false, _isScreenshotEnabled = false;
  String _fingerprintKey = "isFingerprintEnabled";
  String _autoLockTime ="";

  @override
  void initState() {
    // TODO: implement initState
    _isFingerprintEnabled = widget.isFingerprintEnabled;
    checkAppSettings();
    _checkBiometric().then((value) => {
          if (value)
            {
              _isFingerprintAvail = true,
            }
        });
    super.initState();
  }

  void restartTimer(PointerEvent details) {
    /// Reset the timer by tapping anywhere on the screen.
    getIt<AutoLock>().syncValueStreamController.sink.add(null);
  }

  checkAppSettings() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _isFingerprintEnabled = _preferences.getBool(_fingerprintKey);

    settings = MyAppSettings(await StreamingSharedPreferences.instance);
    settings.autoLockTime.listen((value) {
      setState(() {
        _autoLockTime = value;
      });
    });

    settings.autoFill.listen((value) {
      _isAutoFill = value;
    });

    settings.autoLocking.listen((value) {
      _isAutoLocking = value;
    });

    settings.enableScreenshot.listen((value) {
      _isScreenshotEnabled = value;
    });

  }

  Future<bool> _checkBiometric() async {
    LocalAuthentication auth = LocalAuthentication();
    bool canCheckBiometric;
    try {
      canCheckBiometric = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }
    return canCheckBiometric;
  }

  _launchURL(String link) async {
    String url = link;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  showSnackBar(BuildContext context) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text("Changes will appear after restart"),
        action: SnackBarAction(
          label: "Restart",
          textColor: Color(0xFFFFFFFF),
          onPressed: () {
            print("Restart");
            Phoenix.rebirth(context);
            // restartApp(context);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: Listener(
        onPointerDown: restartTimer,
        onPointerMove: restartTimer,
        onPointerUp: restartTimer,
        behavior: HitTestBehavior.translucent,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text("Settings"),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 1,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back,
              ),
            ),
          ),
          body: ListView(
            children: [
              Container(
                padding: EdgeInsets.only(left: 16, top: 25, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          color: Colors.orange,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "General",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.orange,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Divider(
                      height: 15,
                      thickness: 2,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SyncAndBackup()));
                      },
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Synchronization & Back-up",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[600],
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 20,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      height: 15,
                      thickness: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Enable auto-fill",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[600],
                          ),
                        ),
                        Switch(
                          value: _isAutoFill,
                          onChanged: (bool val) async {
                            setState(() {
                              _isAutoFill = val;
                            });
                            settings.autoFill.setValue(val);
                          },
                          activeColor: Colors.orange,
                        ),
                      ],
                    ),
                    Divider(
                      height: 15,
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Activate Fingerprint",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[600],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.65,
                              child: Text(
                                "Use the Fingerprint sensor to unlock your vault instead of your Master Password.",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Switch(
                          value: _isFingerprintEnabled,
                          onChanged: (bool val) async {
                            if (_isFingerprintAvail) {
                              setState(() {
                                _isFingerprintEnabled = val;
                              });
                              SharedPreferences _preferences =
                                  await SharedPreferences.getInstance();
                              _preferences.setBool(
                                  _fingerprintKey, _isFingerprintEnabled);
                            } else {
                              print("Fingerprint not available");
                              Fluttertoast.showToast(
                                  msg: "This is Center Short Toast",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  textColor: Colors.black,
                                  fontSize: 16.0);
                            }
                          },
                          activeColor: Colors.orange,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      height: 15,
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.lock,
                          color: Colors.orange,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Security",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.orange,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Divider(
                      height: 15,
                      thickness: 2,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChangeMasterPassword()));
                      },
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Change Master Password",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[600],
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 20,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      height: 15,
                      thickness: 1,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Change Encryption key",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[600],
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 20,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      height: 15,
                      thickness: 1,
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) => AutoLockDialog(autoLockTime: _autoLockTime),
                        ).then((value) {
                          showSnackBar(context);
                        });
                      },
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Auto-lock when not in use",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    _autoLockTime,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 20,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      height: 15,
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Activate auto locking",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.65,
                              child: Text(
                                "Lock 5 seconds after screen turns off.",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Switch(
                          value: _isAutoLocking,
                          onChanged: (bool val) async {
                            setState(() {
                              _isAutoLocking = val;
                            });
                            settings.autoLocking.setValue(val);
                          },
                          activeColor: Colors.orange,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      height: 15,
                      thickness: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Enable screenshots",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[600],
                          ),
                        ),
                        Switch(
                          value: _isScreenshotEnabled,
                          onChanged: (bool val) async {
                            setState(() {
                              _isScreenshotEnabled = val;
                            });
                            settings.enableScreenshot.setValue(val);
                          },
                          activeColor: Colors.orange,
                        ),
                      ],
                    ),
                    Divider(
                      height: 15,
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.accessibility,
                          color: Colors.orange,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "About",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.orange,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Divider(
                      height: 15,
                      thickness: 2,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "App Version",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.65,
                              child: Text(
                                "1.0.0+1",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      height: 15,
                      thickness: 1,
                    ),
                    GestureDetector(
                      onTap: () {
                        Wiredash.of(context).show();
                      },
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Contact Support",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[600],
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 20,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      height: 15,
                      thickness: 1,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (_) => PrivacyPolicy())),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "EULA & Privacy Policy",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[600],
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 20,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      height: 15,
                      thickness: 1,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Open Source libraries",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[600],
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 20,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      height: 15,
                      thickness: 1,
                    ),
                    GestureDetector(
                      onTap: () => _launchURL('https://google.com'),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "FAQ",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      height: 15,
                      thickness: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
