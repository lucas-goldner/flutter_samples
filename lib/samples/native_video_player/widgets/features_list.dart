import 'package:flutter/material.dart';
import 'feature_item.dart';

class FeaturesList extends StatelessWidget {
  const FeaturesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Features',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              const FeatureItem('Play, Pause, and Stop controls'),
              const FeatureItem('Playback speed control (0.5x - 2.0x)'),
              const FeatureItem('Volume control'),
              const FeatureItem('Loop/Repeat functionality'),
              const FeatureItem('Position tracking and seeking'),
              const FeatureItem('Load videos from assets and network'),
              const FeatureItem('Event listeners for all status changes'),
              const FeatureItem('Native implementation on iOS, Android, macOS'),
              const FeatureItem('Video metadata (duration, dimensions)'),
            ],
          ),
        ),
      ),
    );
  }
}
