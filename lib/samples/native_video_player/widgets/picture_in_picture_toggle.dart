import 'package:flutter/material.dart';
import 'package:golden_video_player/golden_video_player.dart';

class PictureInPictureToggle extends StatelessWidget {
  final bool isPictureInPictureActive;
  final VideoController? controller;

  const PictureInPictureToggle({
    super.key,
    required this.isPictureInPictureActive,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Picture in Picture',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: controller == null
                  ? null
                  : isPictureInPictureActive
                      ? controller!.exitPictureInPicture
                      : controller!.enterPictureInPicture,
              icon: Icon(
                isPictureInPictureActive
                    ? Icons.close_fullscreen
                    : Icons.open_in_new,
              ),
              label: Text(
                isPictureInPictureActive ? 'Exit PiP' : 'Enter PiP',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
