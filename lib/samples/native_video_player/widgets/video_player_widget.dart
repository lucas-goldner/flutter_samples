import 'package:flutter/material.dart';
import 'package:golden_video_player/golden_video_player.dart';

class VideoPlayerWidget extends StatelessWidget {
  final void Function(NativeVideoPlayerController) onViewReady;
  final bool showNativeControls;

  const VideoPlayerWidget({
    super.key,
    required this.onViewReady,
    this.showNativeControls = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      height: 250,
      margin: const EdgeInsets.all(16),
      child: NativeVideoPlayerView(
        onViewReady: onViewReady,
        showNativeControls: showNativeControls,
      ),
    );
  }
}
