import 'package:shared_preferences/shared_preferences.dart';

class VideoSharedPreference {
  List<Map<String, dynamic>> videos = [
    {
      "title": "first Video",
      "videoKey": "first",
      "videoUrl":
          "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4"
    },
    {
      "title": "second Video",
      "videoKey": "second",
      "videoUrl":
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"
    },
    {
      "title": "third Video",
      "videoKey": "third",
      "videoUrl":
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4"
    }
  ];
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
