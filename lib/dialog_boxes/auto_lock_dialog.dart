import 'package:flutter/material.dart';
import 'package:secret_keeper/app_settings.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

enum AutoLockTime { off, sec30, min1, min5, min30 }

class AutoLockDialog extends StatefulWidget {

  final String autoLockTime;

  const AutoLockDialog({Key key, this.autoLockTime}) : super(key: key);

  @override
  _AutoLockDialogState createState() => _AutoLockDialogState();
}

class _AutoLockDialogState extends State<AutoLockDialog> {

  MyAppSettings settings;

  AutoLockTime _time;
  String _value = "";

  @override
  void initState() {
    // TODO: implement initState
    switch (widget.autoLockTime) {
      case "Off":
        _time = AutoLockTime.off;
        break;
      case "30 seconds":
        _time = AutoLockTime.sec30;
        break;
      case "1 minute":
        _time = AutoLockTime.min1;
        break;
      case "5 minute":
        _time = AutoLockTime.min5;
        break;
      case "30 minute":
        _time = AutoLockTime.min30;
        break;
    }
    super.initState();
  }

  setAutoLockTime() async {
    settings = MyAppSettings(await StreamingSharedPreferences.instance);
    settings.autoLockTime.setValue(_value);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Center(
      child: SingleChildScrollView(
        child: Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: width * 0.05),
          elevation: 15,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10.0, top: 20.0, right: 10.0),
                  child: Text(
                    "Auto-lock when not in use",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: 5.0, top: 15.0, right: 10.0, bottom: 15.0),
                  child: Column(
                    children: [
                      RadioListTile<AutoLockTime>(
                        title: const Text('Off'),
                        value: AutoLockTime.off,
                        groupValue: _time,
                        activeColor: Colors.orange,
                        onChanged: (AutoLockTime value) {
                            _time = value;
                            _value = "Off";
                          setAutoLockTime();
                          Navigator.pop(context);
                        },
                      ),
                      RadioListTile<AutoLockTime>(
                        title: const Text('30 seconds'),
                        value: AutoLockTime.sec30,
                        groupValue: _time,
                        activeColor: Colors.orange,
                        onChanged: (AutoLockTime value) {
                            _time = value;
                            _value = "30 seconds";
                          setAutoLockTime();
                          Navigator.pop(context);
                        },
                      ),
                      RadioListTile<AutoLockTime>(
                        title: const Text('1 minute'),
                        value: AutoLockTime.min1,
                        groupValue: _time,
                        activeColor: Colors.orange,
                        onChanged: (AutoLockTime value) {
                            _time = value;
                            _value = "1 minute";
                          setAutoLockTime();
                          Navigator.pop(context);
                        },
                      ),
                      RadioListTile<AutoLockTime>(
                        title: const Text('5 minute'),
                        value: AutoLockTime.min5,
                        groupValue: _time,
                        activeColor: Colors.orange,
                        onChanged: (AutoLockTime value) {
                            _time = value;
                            _value = "5 minute";
                          setAutoLockTime();
                          Navigator.pop(context);
                        },
                      ),
                      RadioListTile<AutoLockTime>(
                        title: const Text('30 minute'),
                        value: AutoLockTime.min30,
                        groupValue: _time,
                        activeColor: Colors.orange,
                        onChanged: (AutoLockTime value) {
                            _time = value;
                            _value = "30 minute";
                          setAutoLockTime();
                          Navigator.pop(context);
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          MaterialButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              "CANCEL",
                              style: TextStyle(
                                color: Colors.orange,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
