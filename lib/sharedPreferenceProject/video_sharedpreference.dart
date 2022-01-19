import 'package:shared_preferences/shared_preferences.dart';

class VideoSharedPreference {
  static SharedPreferences? _preferences;
  static const keyName = 'videoName';

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future setVideoDuration(int time) async {
    await _preferences!.setInt(keyName, time);
  }

  static int getVideoDuration() {
    return _preferences!.getInt(keyName)!;
  }
}
