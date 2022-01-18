import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_package/widget/other/floating_action_button_widget.dart';
import 'package:video_player_package/widget/video_player_widget.dart';

class FilePlayerWidget extends StatefulWidget {
  @override
  _FilePlayerWidgetState createState() => _FilePlayerWidgetState();
}

class _FilePlayerWidgetState extends State<FilePlayerWidget> {
  final File file = File('/storage/emulated/0/Download/messi.mp4');
  VideoPlayerController? controller;

  @override
  void initState() {
    super.initState();

    if (file.existsSync()) {
      controller = VideoPlayerController.file(file)
        ..addListener(() => setState(() {}))
        ..setLooping(true)
        ..initialize().then((_) => controller!.play());
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMuted = controller!.value.volume == 0;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: VideoPlayerWidget(controller: controller!),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                      onPressed: () {
                        controller!.pause();
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
            ],
          ),
          SizedBox(height: 20),
          buildAddButton(),
        ],
      ),
    );
  }

  Widget buildAddButton() => Container(
        padding: EdgeInsets.all(32),
        child: FloatingActionButtonWidget(
          onPressed: () async {
            final file = await pickVideoFile();
            if (file == null) return;

            controller = VideoPlayerController.file(file)
              ..addListener(() => setState(() {}))
              ..setLooping(true)
              ..initialize().then((_) {
                controller!.play();
                setState(() {});
              });
          },
        ),
      );

  Future<File?> pickVideoFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.video);
    if (result == null) return null;

    return File(result.files.single.path!);
  }
}
