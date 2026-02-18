import 'package:flutter/material.dart';

class VideoInfoCard extends StatelessWidget {
  final bool isPlaying;
  final Duration currentPosition;
  final Duration videoDuration;

  const VideoInfoCard({
    super.key,
    required this.isPlaying,
    required this.currentPosition,
    required this.videoDuration,
  });

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Playback Status:',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Chip(
                  label: Text(isPlaying ? 'Playing' : 'Paused'),
                  backgroundColor: isPlaying ? Colors.green : Colors.grey,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Position: ${_formatDuration(currentPosition)}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  'Duration: ${_formatDuration(videoDuration)}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: videoDuration.inMilliseconds > 0
                    ? currentPosition.inMilliseconds / videoDuration.inMilliseconds
                    : 0,
                minHeight: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
