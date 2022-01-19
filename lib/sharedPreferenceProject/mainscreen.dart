import 'package:flutter/material.dart';
import 'package:video_player_package/sharedPreferenceProject/networkvideoPlayer.dart';

class SharedPrefWidget extends StatefulWidget {
  const SharedPrefWidget({Key? key}) : super(key: key);

  @override
  _SharedPrefWidgetState createState() => _SharedPrefWidgetState();
}

class _SharedPrefWidgetState extends State<SharedPrefWidget> {
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
  //https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
  //'https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4'
  //'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4'
  //"https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
  //"https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4"
  //"https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4"
  //"https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('SharedPreference')),
        body: ListView.builder(
          itemCount: videos.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return NetworkPlayersWidget(
                      videoUrl: videos[index]["videoUrl"],
                    );
                  },
                ));
              },
              child: Container(
                height: 60,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blue),
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text("${videos[index]["title"]}"),
                ),
              ),
            );
          },
        ));
  }
}
