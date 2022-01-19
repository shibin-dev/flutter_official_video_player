import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_package/main.dart';
import 'package:video_player_package/sharedPreferenceProject/video_sharedpreference.dart';
import 'package:video_player_package/widget/other/floating_action_button_widget.dart';
import 'package:video_player_package/widget/other/textfield_widget.dart';
import 'package:video_player_package/widget/video_player_widget.dart';

class NetworkPlayersWidget extends StatefulWidget {
  final String videoUrl;
  NetworkPlayersWidget({required this.videoUrl});
  @override
  _NetworkPlayersWidgetState createState() => _NetworkPlayersWidgetState();
}

class _NetworkPlayersWidgetState extends State<NetworkPlayersWidget> {
  final textController = TextEditingController(text: urlYoutubeVideo);
  VideoPlayerController? controller;
  int time = 0;
  @override
  void initState() {
    super.initState();
    time = VideoSharedPreference.getVideoDuration();
    controller = VideoPlayerController.network(widget.videoUrl)
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) {
        controller!.seekTo(Duration(seconds: time));
        controller!.play();
      });
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var currentPlayTime = controller!.value.position.toString().substring(0, 7);
    var totalDuartion = controller!.value.duration.toString().substring(0, 7);
    //int time = 0;
    final isMuted = controller!.value.volume == 0;
    return Scaffold(
      appBar: AppBar(
        title: Text('Video'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined),
          onPressed: () async {
            print('here is the backbutton');
            controller!.pause();
            time = controller!.value.position.inSeconds;
            print("position when we back button press : $time");
            await VideoSharedPreference.setVideoDuration(time);
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            VideoPlayerWidget(controller: controller!),
            //buildTextField(),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //if (controller != null && controller!.value.isInitialized)
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.red,
                  child: IconButton(
                    icon: Icon(
                      isMuted ? Icons.volume_mute : Icons.volume_up,
                      color: Colors.white,
                      size: 15,
                    ),
                    onPressed: () => controller!.setVolume(isMuted ? 1 : 0),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      Duration currentPosition = controller!.value.position;
                      Duration targetPosition =
                          currentPosition - const Duration(seconds: 5);
                      controller!.seekTo(targetPosition);
                    },
                    icon: Icon(Icons.fast_rewind)),
                controller!.value.isPlaying
                    ? IconButton(
                        onPressed: () async {
                          print('here is the video');
                          controller!.pause();
                          time = controller!.value.position.inSeconds;
                          print("position when we pause : $time");
                          await VideoSharedPreference.setVideoDuration(time);
                        },
                        icon: Icon(Icons.pause))
                    : IconButton(
                        onPressed: () {
                          controller!.play();
                        },
                        icon: Icon(Icons.play_arrow)),
                IconButton(
                    onPressed: () {
                      Duration currentPosition = controller!.value.position;
                      Duration targetPosition =
                          currentPosition + const Duration(seconds: 5);
                      controller!.seekTo(targetPosition);
                    },
                    icon: Icon(Icons.double_arrow_rounded)),
                Text('$currentPlayTime/$totalDuartion')
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField() => Container(
        padding: EdgeInsets.all(32),
        child: Row(
          children: [
            Expanded(
              child: TextFieldWidget(
                controller: textController,
                hintText: 'Enter Video Url',
              ),
            ),
            const SizedBox(width: 12),
            FloatingActionButtonWidget(
              onPressed: () {
                if (textController.text.trim().isEmpty) return;
              },
            ),
          ],
        ),
      );
}