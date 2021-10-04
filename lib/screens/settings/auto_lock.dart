import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/lock_screen.dart';
import 'package:get_it/get_it.dart';
import 'package:secret_keeper/app_settings.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

final defaultSyncValue = _time;
int _time = 1000;
final getIt = GetIt.instance;

class AutoLock{
  /// Timer to run countdown.
  Stream<Null> timer;
  StreamSubscription<Null> listener;

  /// Streams that control the value of the counter used in the timer.
  final syncValueStreamController = StreamController<void>();
  StreamSubscription<void> syncValueListener;
  get syncValueStream => syncValueStreamController.stream;

  AutoLock(BuildContext context) {
    setTime().then((value) {

      print(value);

      /// Counters to be used in the timer
      var syncValue = value;

      // Delayed to get context
      Future.delayed(Duration.zero, () {
        timer = Stream.periodic(Duration(seconds: 1), (_) {
          // Re rendering the current value with setState to check the behavior.
          // setState(() {
          syncValue--;
          print(syncValue);
          // });

          if (syncValue == 0) {
            // Lock the screen when it reaches zero.
            showLockScreen(context: context);
          }
        });

        // Run the timer
        listener = timer.listen((event) {});
      });

      /// Open a stream to reset the timer.
      syncValueListener = syncValueStream.listen((_) {
        // Re rendering the current value with setState to check the behavior.
        // setState(() {
        // Reset counter.
        syncValue = defaultSyncValue;
        // });
      });
    });
  }

  Future<int> setTime() async {
    final preferences = await StreamingSharedPreferences.instance;
    final settings = MyAppSettings(preferences);
    var timing = settings.autoLockTime.getValue();
    print(timing);
    switch(timing){
      case "Off":
        _time = -1;
        return -1;
        break;
      case "30 seconds":
        _time = 30;
        return 30;
        break;
      case "1 minute":
        _time = 60;
        return 60;
        break;
      case "5 minute":
        _time = 300;
        return 300;
        break;
      case "30 minute":
        _time = 1800;
        return 1800;
        break;
    }
    return 5555;
  }

  void dispose() {
    // Close all streams
    listener.cancel();
    syncValueListener.cancel();
    syncValueStreamController.close();
  }

}