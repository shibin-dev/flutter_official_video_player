import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_package/widget/basic_overlay_widget.dart';
import 'package:video_player_package/widget/video_player_widget.dart';

import '../../main.dart';
import '../other/floating_action_button_widget.dart';
import '../other/textfield_widget.dart';

class NetworkPlayerWidget extends StatefulWidget {
  @override
  _NetworkPlayerWidgetState createState() => _NetworkPlayerWidgetState();
}

class _NetworkPlayerWidgetState extends State<NetworkPlayerWidget> {
  final textController = TextEditingController(text: urlYoutubeVideo);
  VideoPlayerController? controller;

  @override
  void initState() {
    super.initState();

    controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4')
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) => controller!.play());
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMuted = controller!.value.volume == 0;
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          VideoPlayerWidget(controller: controller!),
          //buildTextField(),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              if (controller != null && controller!.value.isInitialized)
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
              controller!.value.isPlaying
                  ? IconButton(
                      onPressed: () {
                        controller!.pause();
                      },
                      icon: Icon(Icons.pause))
                  : IconButton(
                      onPressed: () {
                        controller!.play();
                      },
                      icon: Icon(Icons.play_arrow))
            ],
          ),
        ],
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
