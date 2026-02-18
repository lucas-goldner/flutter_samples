import 'package:flutter/material.dart';

class PlaybackSpeedControl extends StatelessWidget {
  final double playbackSpeed;
  final ValueChanged<double> onSpeedChanged;

  const PlaybackSpeedControl({
    super.key,
    required this.playbackSpeed,
    required this.onSpeedChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Playback Speed',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                '${playbackSpeed.toStringAsFixed(2)}x',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          Slider(
            value: playbackSpeed,
            min: 0.5,
            max: 2.0,
            divisions: 6,
            label: playbackSpeed.toStringAsFixed(2),
            onChanged: onSpeedChanged,
          ),
        ],
      ),
    );
  }
}
