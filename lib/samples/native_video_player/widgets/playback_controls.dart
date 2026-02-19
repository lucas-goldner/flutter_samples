import 'package:flutter/material.dart';
import 'package:golden_video_player/golden_video_player.dart';

class PlaybackControls extends StatelessWidget {
  final bool isPlaying;
  final bool isLooping;
  final NativeVideoPlayerController? controller;
  final VoidCallback onToggleLoop;

  const PlaybackControls({
    super.key,
    required this.isPlaying,
    required this.isLooping,
    required this.controller,
    required this.onToggleLoop,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Playback Controls',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton.small(
                heroTag: 'play-pause-btn',
                onPressed: controller == null
                    ? null
                    : isPlaying
                        ? controller!.pause
                        : controller!.play,
                child: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
              ),
              FloatingActionButton.small(
                heroTag: 'stop-btn',
                onPressed: controller?.stop,
                child: const Icon(Icons.stop),
              ),
              FloatingActionButton.small(
                heroTag: 'loop-btn',
                onPressed: onToggleLoop,
                child: Icon(
                  Icons.repeat,
                  color: isLooping ? Colors.blue : null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
