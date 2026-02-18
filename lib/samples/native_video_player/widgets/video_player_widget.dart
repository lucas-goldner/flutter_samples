import 'package:flutter/material.dart';
import 'package:native_video_player/native_video_player.dart';

class VideoPlayerWidget extends StatelessWidget {
  final Function(NativeVideoPlayerController) onViewReady;

  const VideoPlayerWidget({
    super.key,
    required this.onViewReady,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      height: 250,
      margin: const EdgeInsets.all(16),
      child: NativeVideoPlayerView(
        onViewReady: onViewReady,
      ),
    );
  }
}
