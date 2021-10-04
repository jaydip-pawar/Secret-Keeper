import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class MyAppSettings {
  MyAppSettings(StreamingSharedPreferences preferences)
      : autoLockTime = preferences.getString('autoLockTime', defaultValue: 'Off'),
        autoFill = preferences.getBool("autoFill", defaultValue: false),
        autoLocking = preferences.getBool("autoLocking", defaultValue: false),
        enableScreenshot = preferences.getBool("enableScreenshot", defaultValue: false);

  final Preference<String> autoLockTime;
  final Preference<bool> autoFill;
  final Preference<bool> autoLocking;
  final Preference<bool> enableScreenshot;
}